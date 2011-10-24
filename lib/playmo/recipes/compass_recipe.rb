module Playmo
  module Recipes
    class CompassRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/compass_recipe', __FILE__)

      def setup
        question "Would you like to use Compass in this project?" => :install_compass
      end

      def install_compass
        gem "compass", "~> 0.12.alpha.0"
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/application_controller_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::ApplicationControllerRecipe, Playmo::Recipes::CompassRecipe) if defined?(Playmo::Cookbook)
