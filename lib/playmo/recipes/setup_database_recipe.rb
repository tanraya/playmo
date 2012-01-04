module Playmo
  module Recipes
    class SetupDatabaseRecipe < Playmo::Recipe
      def setup
        silently do
          Event.events.listen(:after_install) do |event_data|
            run "cd #{application_name} && rake db:create"
            run "cd #{application_name} && rake db:migrate"
            run "cd #{application_name} && rake db:seed"
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/rvm_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::RvmRecipe, Playmo::Recipes::SetupDatabaseRecipe) if defined?(Playmo::Cookbook)