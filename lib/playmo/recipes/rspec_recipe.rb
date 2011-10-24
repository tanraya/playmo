module Playmo
  module Recipes
    class RspecRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/rspec_recipe', __FILE__)

      def setup
        question "Would you like to use Rspec in this project?" => :install_rspec
      end

    protected

      def install_rspec
        gem 'rspec'

        # TODO: copy helpers etc
        # TODO: factory_girl etc
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::RspecRecipe) if defined?(Playmo::Cookbook)