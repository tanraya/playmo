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

  autoload :Question
  autoload :Answer
  autoload :Silent
  autoload :Choice
  autoload :Cookbook
  autoload :Recipe
  
  #autoload :Generators, 'playmo/generators/base'
  #class Railtie < ::Rails::Railtie
  #  config.app_generators.scaffold_controller = :playmo_controller
  #end
end
