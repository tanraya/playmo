module Playmo
  module Recipes
    class SetupDatabaseRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/setup_database_recipe', __FILE__)

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
Playmo::Cookbook.instance.use(Playmo::Recipes::SetupDatabaseRecipe) if defined?(Playmo::Cookbook)