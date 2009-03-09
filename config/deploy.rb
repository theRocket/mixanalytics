require 'erb'

set :application, "rhosync"
set :repository,  "git://github.com/rhomobile/rhosync.git"

########################################################################

STAGES = %w(staging production) 

STAGES.each do |name| 
  desc "Set the target stage to `#{name}'." 
  task(name) do 
    set :stage, name.to_sym
    set :rails_env, name.to_sym 
    load "config/deploy/#{stage}" 
  end 
end 

on :start, :except => STAGES do 
  if !exists?(:stage) 
    abort "no stage specified, please choose one of #{STAGES.join(", ")}" 
  end 
end
 
########################################################################

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:

default_run_options[:pty] = true

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :use_sudo, false


set :user, "www-data"

set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

# set :copy_strategy, :export
set :ssh_options, { :forward_agent => true }

namespace :deploy do
 desc "Restarting mod_rails with restart.txt"
 task :restart, :roles => :app, :except => { :no_release => true } do

   run "touch #{current_path}/tmp/restart.txt"
 end
 
 desc "Symlink the database config"
 task :symlink_db_config do
   run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
 end

 [:start, :stop].each do |t|
   desc "#{t} task is a no-op with mod_rails"
   task t, :roles => :app do ; end
 end
 
 after "deploy:update_code", "deploy:symlink_db_config"
end

namespace :rake do
 desc "Load the sample data remotely"
 task :samples do
   run("cd #{deploy_to}/current; /usr/bin/rake db:fixtures:samples RAILS_ENV=production")
 end
 task :bootstrap do
   run("cd #{deploy_to}/current; /usr/bin/rake db:bootstrap RAILS_ENV=production")
 end
end
