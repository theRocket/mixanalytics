set :application, "rhosync"

set :repository,  "git://github.com/rhomobile/rhosync.git"
set :repository_cache, "git_cache"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"

set :ssh_options, { :forward_agent => true }

# options to override in the stage file
#set :deploy_to, "/remote/deployment/path"
#set :user, "www-data"
#server "rhosync.rhohub.com", :app, :web, :db, :primary => true

namespace :deploy do
  desc "Upload database configs to server"
  task :upload_db_configs do
    run "mkdir -p #{shared_path}/config"
    top.upload('config/database.yml',"#{shared_path}/config/database.yml")
    top.upload('config/s3.yml',"#{shared_path}/config/s3.yml")
  end
 
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  desc "Symlink the database config"
  task :symlink_db_config do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/s3.yml #{latest_release}/config/s3.yml"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
 
  after "deploy:setup", "deploy:upload_db_configs"
  after "deploy:update_code", "deploy:symlink_db_config"
end

namespace :rake do
  desc "Load the sample data remotely"
  task :samples do
    run("cd #{deploy_to}/current; /usr/bin/rake db:fixtures:samples RAILS_ENV=#{:rails_env}")
  end
  task :bootstrap do
    run("cd #{deploy_to}/current; /usr/bin/rake db:bootstrap RAILS_ENV=#{:rails_env}")
  end
end