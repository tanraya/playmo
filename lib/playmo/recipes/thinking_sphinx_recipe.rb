recipe :thinking_sphinx do
  description 'Something'
  after :unicorn
  
  ask "Would you like to use Thinking Sphinx in this project?" do
    gem 'thinking-sphinx', '~> 2.0.10'

    # TODO Add Whenever integration (see https://github.com/nesquena/cap-recipes)
    #Event.events.listen(:after_install) do |event_data|
      template 'sphinx.yml', 'config/sphinx.yml'
    #end
  end
end

__END__


module Playmo
  module Recipes
    class ThinkingSphinxRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/thinking_sphinx_recipe', __FILE__)

      def setup
        question "Would you like to use Thinking Sphinx in this project?" => :install_ts
      end

    protected

      def install_ts
        gem 'thinking-sphinx', '~> 2.0.10'

        # TODO Add Whenever integration (see https://github.com/nesquena/cap-recipes)
        Event.events.listen(:after_install) do |event_data|
          template 'sphinx.yml', 'config/sphinx.yml'
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/unicorn_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::UnicornRecipe, Playmo::Recipes::ThinkingSphinxRecipe) if defined?(Playmo::Cookbook)