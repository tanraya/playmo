require 'rails/all'
require File.dirname(__FILE__) + '/../lib/playmo/recipe'
require File.dirname(__FILE__) + '/../lib/generators/playmo/recipes/home_controller_recipe'
recipe = Playmo::Generators::Recipes::HomeControllerRecipe.new