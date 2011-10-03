module Playmo
  module Recipes
    class CapistranoRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/capistrano_recipe', __FILE__)

      def setup
        question "Would you like to deploy project with Capistrano?" => :install_capistrano
      end

      def install_capistrano
        gem 'capistrano'

        # TODO: Copy deploy.rb

        Event.events.listen(:after_install) do |event_data|
          capify!
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::CapistranoRecipe) if defined?(Playmo::Cookbook)