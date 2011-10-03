module Playmo
  module Recipes
    class RvmRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/rvm_recipe', __FILE__)

      def setup
        silently do

        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::RvmRecipe) if defined?(Playmo::Cookbook)