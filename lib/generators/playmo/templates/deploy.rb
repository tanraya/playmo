# cap deploy:setup
# cap deploy
require 'thinking_sphinx/deploy/capistrano'

set :application, "lowjob"

set :repository,     'gitosis@109.74.2.126:lowjob.git'
set :scm,            :git
set :deploy_via,     :remote_cache
set :branch,         :master
#set :scm_verbose,    true
set :scm_username,   'demerest'
#set :scm_passphrase, ''

#ssh_options[:paranoid]      = false
ssh_options[:forward_agent] = true

set :user, "root"
set :use_sudo, false
server "109.74.2.126", :app, :web, :db, :primary => true

set :deploy_to, "/home/projects/#{application}"
set :rails_env, "production"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Bundle and minify the JS and CSS files'
  task :precache_assets, :roles => :app do
    root_path   = File.expand_path(File.dirname(__FILE__) + '/..')
    assets_path = "#{root_path}/public/assets"
    gem_path    = ENV['GEM_PATH']
    run_locally "jammit"
    top.upload assets_path, "#{current_release}/public", :via => :scp, :recursive => true
  end
end

namespace :bundle do
  task :install do
    run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle install"
  end
end

after 'deploy:setup',   'thinking_sphinx:shared_sphinx_folder'
after 'deploy:symlink', 'deploy:precache_assets'
after 'deploy:symlink', 'bundle:install'
after 'bundle:install', 'deploy:migrate'
