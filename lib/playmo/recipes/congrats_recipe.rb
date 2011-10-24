module Playmo
  module Recipes
    class CongratsRecipe < Playmo::Recipe
      def setup
        # TODO: need silently block
        Playmo::Event.events.listen(:after_playmo_install) do |event_data|
          say "\n"
          say "*******************************************************************"
          say "Congratulations! All files has been installed successfully."
          say "You can read some docs on https://github.com/tanraya/playmo"
          say "\n"
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/git_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::GitRecipe, Playmo::Recipes::CongratsRecipe) if defined?(Playmo::Cookbook)