module Playmo
  module Recipes
    class AssetsRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/assets_recipe', __FILE__)

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
Playmo::Cookbook.instance.use(Playmo::Recipes::AssetsRecipe) if defined?(Playmo::Cookbook)
