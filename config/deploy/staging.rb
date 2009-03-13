set :deploy_to, "/var/www/apps/dev/#{application}"
set :user, "www-data"
server "staging.rhosync.rhohub.com", :app, :web, :db, :primary => true

run "echo 'Setting staging environment'"
