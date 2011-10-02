module Playmo
  module Generators
    module Recipes
      class AssetsRecipe < Playmo::Recipe
        source_root File.expand_path('../templates/assets_recipe', __FILE__)

        def setup
          silently do
            directory 'images/',      'app/assets/images/'
            directory 'stylesheets/', 'app/assets/stylesheets/'
            #copy_file 'images/bg.jpg', 'app/assets/images/bg.jpg'
            #copy_file 'images/input-bg.gif', 'app/assets/images/input-bg.gif'

            #empty_directory 'app/assets/stylesheets/partials'
            remove_file 'app/assets/stylesheets/application.css'

            #copy_file 'stylesheets/application.css.scss', 'app/assets/stylesheets/application.css.scss'
            #copy_file 'stylesheets/media.css.scss', 'app/assets/stylesheets/media.css.scss'
            #copy_file 'stylesheets/partials/', 'app/assets/stylesheets/partials/'
            #copy_file 'stylesheets/partials/', 'app/assets/stylesheets/partials/'
            #copy_file 'stylesheets/partials/', 'app/assets/stylesheets/partials/'
            #copy_file 'stylesheets/partials/', 'app/assets/stylesheets/partials/'
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::AssetsRecipe) if defined?(Playmo::Cookbook)
