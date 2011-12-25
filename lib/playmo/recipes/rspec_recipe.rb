module Playmo
  module Recipes
    class RspecRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/rspec_recipe', __FILE__)

      def setup
        question "Would you like to use Rspec in this project?" => :install_rspec
      end

    protected

      def install_rspec
        gem 'rspec-rails'

        Event.events.listen(:after_install) do |event_data|
          generate "rspec:install"
        end
        
        # TODO: copy helpers etc
        # TODO: factory_girl etc
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/application_helper_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::ApplicationHelperRecipe, Playmo::Recipes::RspecRecipe) if defined?(Playmo::Cookbook)