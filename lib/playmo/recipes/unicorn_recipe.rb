recipe :unicorn do
  description 'Something'
  after :application_helper
  
  question "Would you like to use Unicorn as web server in production?" do
    gem "unicorn", :group => :production
    template "unicorn.rb", "config/unicorn.rb"
  end
end

__END__

module Playmo
  module Recipes
    class UnicornRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/unicorn_recipe', __FILE__)

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
