module Playmo
  module Recipes
    class FormsRecipe < Playmo::Recipe
      def setup
        question "Which form builder you prefer?" do
          answer "Use default form_for helper" => :use_default
          answer "Simple Form"                 => :install_simple_form
          answer "Formtastic"                  => :install_formtastic
        end
      end

    protected

      def use_default
        # do nothing
      end

      def install_simple_form
        gem 'simple_form'

        Event.events.listen(:after_install) do |event_data|
          generate "simple_form:install"
        end
      end

      def install_formtastic
        gem 'formtastic'

        Event.events.listen(:after_install) do |event_data|
          generate "formtastic:install"
        end
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/compass_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::CompassRecipe, Playmo::Recipes::FormsRecipe) if defined?(Playmo::Cookbook)