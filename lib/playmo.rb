# encoding: utf-8

require 'rails/all'

#require 'compass'
#Compass::Frameworks.register("playmo", :path => "#{File.dirname(__FILE__)}/..")

#if defined?(ActionController)
#  require File.join(File.dirname(__FILE__), 'app', 'helpers', 'playmo_helper')
#  ActionController::Base.helper(PlaymoHelper)
#end

# Recipes order:
# MarkupRecipe
# AssetsRecipe
# ApplicationControllerRecipe
# CompassRecipe
# FormsRecipe
# JavascriptFrameworkRecipe
# DeviseRecipe
# LayoutRecipe
# HomeControllerRecipe
# ApplicationHelperRecipe
# RspecRecipe
# CapistranoRecipe
# RvmRecipe
# SetupDatabaseRecipe
# GitRecipe
# CongratsRecipe

module Playmo
  extend ActiveSupport::Autoload

  autoload :Cli
  autoload :Event
  autoload :Question
  autoload :Answer
  autoload :Silent
  autoload :Choice
  autoload :Cookbook
  autoload :Recipe

  Dir["#{File.dirname(__FILE__)}/playmo/recipes/*_recipe.rb"].each { |file| require file }

  #autoload :Generators, 'playmo/generators/base'
  #class Railtie < ::Rails::Railtie
  #  config.app_generators.scaffold_controller = :playmo_controller
  #end
end
