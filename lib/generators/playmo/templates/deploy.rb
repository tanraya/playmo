# Uncomment line below if you are using thinking_sphinx
# require 'thinking_sphinx/deploy/capistrano'

set :application, "<app_name>"

set :repository,     '<ssh+git://git@example.com:yourproject.git>'
set :scm,            :git
set :deploy_via,     :remote_cache
set :branch,         :master
set :scm_username,   '<scm_username_here>'

# Uncomment line below if you are using username in your scm
# set :scm_passphrase, ''

ssh_options[:forward_agent] = true

set :user, "root" # Username on the remote server
set :use_sudo, false
server "example.com", :app, :web, :db, :primary => true

set :deploy_to, "</var/www/#{application}>" # Path to your on the remote server
set :rails_env, "production"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Bundle and minify javascripts and stylesheets'
  task :precache_assets, :roles => :app do
    run_locally "rake assets:update"
    #root_path   = File.expand_path(File.dirname(__FILE__) + '/..')
    #assets_path = "#{root_path}/public/assets"
    #gem_path    = ENV['GEM_PATH']
    #run_locally "jammit"
    #top.upload assets_path, "#{current_release}/public", :via => :scp, :recursive => true
  end
end

namespace :bundle do
  task :install do
    run "cd #{deploy_to}/current && RAILS_ENV=#{rails_env} bundle install"
  end
end

# Uncomment line below if you are using thinking_sphinx
# after 'deploy:setup',   'thinking_sphinx:shared_sphinx_folder'
after 'deploy:symlink', 'deploy:precache_assets'
after 'deploy:symlink', 'bundle:install'
after 'bundle:install', 'deploy:migrate'
