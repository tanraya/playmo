module Playmo
  module Recipes
    class RvmRecipe < Playmo::Recipe
      def setup
        silently do
          if system 'which rvm'
            in_root do
              run "rvm #{RUBY_VERSION}@#{application_name} --rvmrc --create" # cd #{application_name} && 
            end
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/capistrano_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::CapistranoRecipe, Playmo::Recipes::RvmRecipe) if defined?(Playmo::Cookbook)