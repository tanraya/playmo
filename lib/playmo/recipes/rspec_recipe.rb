module Playmo
  module Recipes
    class RspecRecipe < Playmo::Recipe
      def setup
        question "Would you like to use Rspec in this project?" => :install_rspec
      end

    protected

      def install_rspec
        gem 'rspec-rails'

        Event.events.listen(:after_install) do |event_data|
          generate "rspec:install"
          remove_dir "test"
          
          inject_into_file "config/application.rb", :after => "class Application < Rails::Application\n" do
            <<-CONTENT.gsub(/^ {10}/, '')
              config.generators do |g|
                g.test_framework :rspec
              end
            CONTENT
          end
        end
        
        # TODO: copy helpers etc
        # TODO: factory_girl etc
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/thinking_sphinx_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::ThinkingSphinxRecipe, Playmo::Recipes::RspecRecipe) if defined?(Playmo::Cookbook)