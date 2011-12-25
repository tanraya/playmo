module Playmo
  module Recipes
    class CapistranoRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/capistrano_recipe', __FILE__)

      def setup
        question "Would you like to deploy project with Capistrano?" => :install_capistrano
      end

      def install_capistrano
        gem 'capistrano'

        # TODO: Copy deploy.rb
        Event.events.listen(:after_install) do |event_data|
          capify!
          remove_file "config/deploy.rb"
          template    "deploy.rb", "config/deploy.rb"
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/rspec_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::RspecRecipe, Playmo::Recipes::CapistranoRecipe) if defined?(Playmo::Cookbook)