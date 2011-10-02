module Playmo
  module Generators
    module Recipes
      class ApplicationControllerRecipe < Playmo::Recipe
        source_root File.expand_path('../templates/application_controller_recipe', __FILE__)

        def setup
          silently do
            remove_file 'app/controllers/application_controller.rb'
            copy_file   'application_controller.rb', 'app/controllers/application_controller.rb'
            empty_directory "app/views/application"
            copy_file "internal_error.html.erb", "app/views/application/internal_error.html.erb"
            copy_file "not_found.html.erb", "app/views/application/not_found.html.erb"
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::ApplicationControllerRecipe) if defined?(Playmo::Cookbook)
