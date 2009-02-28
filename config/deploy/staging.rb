set :deploy_to, "/var/www/apps/staging/#{application}"
server "staging.rhohub.com", :app, :web, :db, :primary => true

#set :tag  'whatever'

run "echo 'Setting staging environment'"
