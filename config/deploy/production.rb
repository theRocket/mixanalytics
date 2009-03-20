set :deploy_to, "/mnt/apps/#{application}"
set :user, "app"
server "rhosync.rhohub.com", :app, :web, :db, :primary => true
#ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/rhomobilekey.pem"]

run "echo 'Setting production environment'"