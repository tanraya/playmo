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

  # autoload all available recipes
=begin
  autoload_at "#{File.dirname(__FILE__)}/playmo/recipes/" do
    autoload :MarkupRecipe
    autoload :AssetsRecipe
    autoload :ApplicationControllerRecipe
    autoload :CompassRecipe
    autoload :FormsRecipe
    autoload :JavascriptFrameworkRecipe
    autoload :DeviseRecipe
    autoload :LayoutRecipe
    autoload :HomeControllerRecipe
    autoload :ApplicationHelperRecipe
    autoload :RspecRecipe
    autoload :CapistranoRecipe
    autoload :RvmRecipe
    autoload :SetupDatabaseRecipe
    autoload :GitRecipe
    autoload :CongratsRecipe
  end
=end

  Dir["#{File.dirname(__FILE__)}/playmo/recipes/*_recipe.rb"].each { |file| require file }

  #autoload :Generators, 'playmo/generators/base'
  #class Railtie < ::Rails::Railtie
  #  config.app_generators.scaffold_controller = :playmo_controller
  #end
end
