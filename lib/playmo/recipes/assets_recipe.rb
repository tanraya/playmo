module Playmo
  module Recipes
    class AssetsRecipe < Playmo::Recipe
      def setup
        silently do
          directory   'images/',      'app/assets/images/'
          directory   'stylesheets/', 'app/assets/stylesheets/'
          remove_file 'app/assets/stylesheets/application.css'
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/markup_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::MarkupRecipe, Playmo::Recipes::AssetsRecipe) if defined?(Playmo::Cookbook)