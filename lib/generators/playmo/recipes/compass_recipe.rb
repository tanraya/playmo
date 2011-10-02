module Playmo
  module Generators
    module Recipes
      class CompassRecipe < Playmo::Recipe
        source_root File.expand_path('../templates/compass_recipe', __FILE__)

        def setup
          question "Would you like to use Compass in this project?" => :install_compass
        end

        def install_compass
          gem 'compass', :git => 'git://github.com/chriseppstein/compass.git'
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::CompassRecipe) if defined?(Playmo::Cookbook)
