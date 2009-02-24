set :deploy_to, "/var/www/apps/#{application}"
server "rhosyncdev.rhohub.com", :app, :web, :db, :primary => true

set :tag  'whatever'

run "echo 'Setting staging environment'"