set :application, "rhosync"
set :repository,  "git://github.com/rhomobile/rhosync.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

server "apps.rhohub.com", :app, :web, :db, :primary => true

set :user, "www-data"

set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end 

namespace :rake do
  desc "Load the sample data remotely"
  task :samples do
    run("cd #{deploy_to}/current; /usr/bin/rake db:fixtures:samples")
  end
end

