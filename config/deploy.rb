require 'capistrano_colors'

set :domain, "vagrant.namics.com"
set :application, "vagrant.namics.com"
set :repository,  "git://github.com/danielkummer/bentobox-4-vagrant.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache




set :scm, :git
set :git_shallow_clone, 1
set :deploy_via, :checkout

ssh_options[:forward_agent] = true
default_run_options[:pty] = true # Must be set for the password prompt from git to work
set :use_sudo, true
set :keep_releases, 5



set :user, "namics"
set :rails_env, "production"

set :deploy_to, "/var/www/#{application}"

role :web, domain
role :app, domain
role :db,  domain, :primary => true


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

