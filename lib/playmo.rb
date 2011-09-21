# encoding: utf-8

require 'rails/all'

#require 'compass'
#Compass::Frameworks.register("playmo", :path => "#{File.dirname(__FILE__)}/..")

if defined?(ActionController)
  require File.join(File.dirname(__FILE__), 'app', 'helpers', 'playmo_helper')
  ActionController::Base.helper(PlaymoHelper)
end

module Playmo
  extend ActiveSupport::Autoload

  autoload :Event
  autoload :Question
  autoload :Answer
  autoload :Silent
  autoload :Choice
  autoload :Cookbook
  autoload :Recipe

  # Require all available recipes
  Dir["#{File.dirname(__FILE__)}/generators/playmo/recipes/*_recipe.rb"].each { |file| require file }

  
  #autoload :Generators, 'playmo/generators/base'
  #class Railtie < ::Rails::Railtie
  #  config.app_generators.scaffold_controller = :playmo_controller
  #end
end
