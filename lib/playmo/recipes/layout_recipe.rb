recipe :layout do
  description 'Something'
  after :devise
  
  # TODO: Add option to make separate files for header & footer
  silently do
    #after :install do
      remove_file 'app/views/layouts/application.html.erb'
      generate :layout, "application #{retrieve(:markup)}"
    #end
  end
end

__END__


module Playmo
  module Recipes
    class LayoutRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/layout_recipe', __FILE__)

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
