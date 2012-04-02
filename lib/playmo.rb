# encoding: utf-8
require 'playmo/version'

begin
  require 'rails/all'
rescue LoadError
  puts "Rails is not installed!"
  puts "It seems to lack some needed gems for further work."
  puts "If you are using RVM it may mean that Playmo was installed to another gemset."
  puts "Try to install Playmo again with 'gem install playmo' or switch to another gemset that already have installed Playmo."
  exit!
end

# Recipes order:
# database
# rails
# setup_database
# locale
# markup
# assets
# application_controller
# compass
# forms
# javascript_framework
# layout
# home_controller
# devise
# cancan
# application_helper
# unicorn
# thinking_sphinx
# rspec
# capistrano
# rvm
# gemfile
# git

module Playmo
  ROOT = File.join(File.dirname(__FILE__), "..")

  extend ActiveSupport::Autoload
  
  class Railtie < Rails::Railtie
    config.app_generators do |g|
      path = File::expand_path('../generators/templates', __FILE__)
      g.templates.unshift path
    end 
  end

  autoload :Cli
  autoload :Event
  autoload :Options
  autoload :Cookbook
  autoload :Recipe

  class ::Object
    include Playmo::Recipe
  end

  $:.unshift("#{ROOT}/recipes/")
  Dir["#{ROOT}/recipes/*_recipe.rb"].each { |f| require f }
end



