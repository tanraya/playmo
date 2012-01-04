module Playmo
  module Recipes
    class LayoutRecipe < Playmo::Recipe
      def setup
        silently do
          Event.events.listen(:after_install) do |event_data|
            remove_file 'app/views/layouts/application.html.erb'
            generate :layout, "application #{retrieve(:markup)}"
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/javascript_framework_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::JavascriptFrameworkRecipe, Playmo::Recipes::LayoutRecipe) if defined?(Playmo::Cookbook)
