module Playmo
  module Recipes
    class ApplicationHelperRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/application_helper_recipe', __FILE__)

      def setup
        silently do
          remove_file 'app/helpers/application_helper.rb'
          copy_file   'application_helper.rb', 'app/helpers/application_helper.rb'

          gsub_file 'config/locales/en.yml', 'en:' do
            <<-CONTENT.gsub(/^ {14}/, '')
              en:
                helpers:
                  application:
                    link_to_delete:
                      link_text: Delete?
                      confirmation: Are you sure?
            CONTENT
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/home_controller_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::HomeControllerRecipe, Playmo::Recipes::ApplicationHelperRecipe) if defined?(Playmo::Cookbook)