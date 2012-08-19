set :application, "CoHoop-Meta"
set :deploy_to,   "/home/ubuntu/www/#{application}"

set :location, '54.247.108.99'

role :web, location                          # Your HTTP server, Apache/etc
role :app, location
role :db,  location, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

default_run_options[:pty] = true
set :repository, "git://github.com/CoHoop/CoHoop-Meta.git"
set :scm, :git
set :branch, "master"

set :user, "ubuntu"
set :use_sudo, true
set :admin_runner, "ubuntu"

ssh_options[:forward_agent] = true
ssh_options[:keys] = ["#{ ENV['HOME']}/.ssh/KEY-CoHoop.pem"]

set :rails_env, 'production'
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

#after 'deploy:setup', 'db:setup'
after :deploy, "deploy:migrate"
