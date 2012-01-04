module Playmo
  module Recipes
    class UnicornRecipe < Playmo::Recipe
      def setup
        question "Would you like to use Unicorn as web server in production?" => :install_compass
      end

      def install_compass
        gem "unicorn", :group => :production
        template "unicorn.rb", "config/unicorn.rb"
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/application_helper_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::ApplicationHelperRecipe, Playmo::Recipes::UnicornRecipe) if defined?(Playmo::Cookbook)
