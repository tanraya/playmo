module Playmo
  module Recipes
    class FormsRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/forms_recipe', __FILE__)

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
          # generate
        end
      end

      def install_formtastic
        gem 'formtastic'

        Event.events.listen(:after_install) do |event_data|
          # generate
        end
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::FormsRecipe) if defined?(Playmo::Cookbook)