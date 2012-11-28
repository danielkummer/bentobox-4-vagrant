require 'capistrano_colors'

set :domain, "vagrant.namics.com"
set :application, "vagrant.namics.com"
set :repository, "git://github.com/danielkummer/bentobox-4-vagrant.git"
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
role :db, domain, :primary => true

task :production do
  set :bundle_without, [:development, :test, :demo]
end

namespace :deploy do
  task :start do
    ;
  end
  task :stop do
    ;
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

namespace :customs do
  desc "Symlink shared configs and folders on each release."
  task :symlink do
    run "ln -nfs #{shared_path}/config/production.pem #{release_path}/config/production.pem"
    #run "rm -rf #{release_path}/public/uploads} && ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
end

after 'deploy:create_symlink','customs:symlink'
after "deploy:update", "deploy:cleanup"

