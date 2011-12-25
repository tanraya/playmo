# cap deploy:setup
# cap deploy
# cap db:seed (on first deploy)
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require 'bundler/capistrano'

# Uncomment this if you are using Thinking Sphinx
#require 'thinking_sphinx/deploy/capistrano'

# Uncomment this if you are using Whenever
#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

set :application,  '<%= application_name %>'
set :domain,       'user@<%= application_name %>'
set :repository,   'https://github.com/exampleuser/<%= application_name %>.git'
set :scm,          :git
set :deploy_via,   :remote_cache
set :branch,       :master
set :scm_username, 'exampleuser'
set :scm_verbose,  true
set :user,        'user'
set :use_sudo,     false

ssh_options[:forward_agent] = true
default_run_options[:pty]   = false

set :keep_releases,    3
set :deploy_to,        "/home/#{user}/htdocs"
set :rails_env,        "production"

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid,  "#{deploy_to}/shared/pids/unicorn.pid"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set(:database_username,    "<%= application_name %>")
set(:development_database) { application + "_development" }
set(:test_database)        { application + "_test" }
set(:production_database)  { application }

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  desc 'Precache assets'
  task :precache_assets, :roles => :app do
    run "cd #{current_release} && bundle exec rake assets:precompile RAILS_ENV=production"
  end
end

namespace :db do
  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path} && bundle exec rake db:seed RAILS_ENV=production"
  end

  desc "Create database yaml in shared path"
  task :configure do
    set :database_password do
      Capistrano::CLI.password_prompt "Database Password: "
    end
    
    db_config = <<-EOF
base: &base
  adapter: mysql2
  encoding: utf8
  username: #{database_username}
  password: #{database_password}
  
development:
  database: #{development_database}
  <<: *base

test:
  database: #{test_database}
  <<: *base

production:
  database: #{production_database}
  <<: *base
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

# Uncomment this if you are using Thinking Sphinx
#after 'deploy:migrate', :roles => [:app] do
#  thinking_sphinx.stop
#  run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
#  thinking_sphinx.configure
#  thinking_sphinx.start
#end

before "deploy:setup",   "db:configure"
before "bundle:install", "db:symlink"
after  "bundle:install", "deploy:migrate"
after  "deploy:migrate", "deploy:precache_assets"

require './config/boot'
