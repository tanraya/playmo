module Playmo
  module Recipes
    class MarkupRecipe < Playmo::Recipe
      def setup
        question "Please choose markup language you prefer to use" do
          answer "Erb (by default)"  => :install_erb
          answer "Haml"              => :install_haml
          answer "Slim"              => :install_slim
        end
      end

    protected

      def install_erb
        # Do nothing
      end

      def install_haml
        gem "haml-rails"
      end

      def install_slim
        gem "slim-rails"
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::MarkupRecipe) if defined?(Playmo::Cookbook)