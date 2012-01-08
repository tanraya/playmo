# encoding: utf-8
require 'rails/all'

# Recipes order:
# rails
# locale
# markup
# assets
# application_controller
# compass
# forms
# javascript_framework
# layout
# devise
# home_controller
# application_helper
# unicorn
# thinking_sphinx
# rspec
# capistrano
# rvm
# setup_database
# gemfile
# git

module Playmo
  extend ActiveSupport::Autoload
  
  class Railtie < Rails::Railtie
    config.app_generators do |g|
      path = File::expand_path('../generators/templates', __FILE__)
      g.templates.unshift path
    end 
  end

  autoload :Version
  autoload :Cli
  autoload :Event
  autoload :Options
  autoload :Cookbook
  autoload :Recipe

  class ::Object
    include Playmo::Recipe
  end

  Dir["#{File.dirname(__FILE__)}/playmo/recipes/*_recipe.rb"].each { |f| require f }
end



