# encoding: utf-8

require 'rails/all'

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
# UnicornRecipe
# ThinkingSphinxRecipe
# RspecRecipe
# CapistranoRecipe
# RvmRecipe
# SetupDatabaseRecipe
# GitRecipe
# GemfileRecipe
# CongratsRecipe



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
  #autoload :Event
  #autoload :Options
  autoload :Cookbook
  autoload :Recipe

  class ::Object
    include Playmo::Recipe
  end

  #
  #puts "Load recipes"
  Dir["#{File.dirname(__FILE__)}/playmo/recipes/*_recipe.rb"].each { |file| require file }

  #require "#{File.dirname(__FILE__)}/playmo/recipes/rails_recipe.rb"
=begin
  require "#{File.dirname(__FILE__)}/playmo/recipes/layout_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/capistrano_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/rspec_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/rvm_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/git_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/gemfile_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/setup_database_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/thinking_sphinx_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/unicorn_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/application_helper_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/markup_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/rails_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/assets_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/application_controller_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/compass_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/forms_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/javascript_framework_recipe.rb"
  require "#{File.dirname(__FILE__)}/playmo/recipes/devise_recipe.rb"
=end
end



