set :deploy_to, "/var/www/apps/dev/#{application}"
set :user, "www-data"
server "dev.rhosync.rhohub.com", :app, :web, :db, :primary => true

run "echo 'Setting production environment'"