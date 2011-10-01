module Playmo
  module Generators
    module Recipes
      class ApplicationHelperRecipe < Playmo::Recipe
        source_root File.expand_path('../templates/application_helper_recipe', __FILE__)

        def setup
          silently do
            remove_file 'app/helpers/application_helper.rb'
            copy_file   'application_helper.rb', 'app/helpers/application_helper.rb'
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::ApplicationHelperRecipe) if defined?(Playmo::Cookbook)
