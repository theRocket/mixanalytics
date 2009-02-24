set :deploy_to, "/var/www/apps/prod/#{application}"
server "rhohub.com", :app, :web, :db, :primary => true


run "echo 'Setting production environment'"