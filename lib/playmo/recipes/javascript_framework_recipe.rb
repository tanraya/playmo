module Playmo
  module Recipes
    class JavascriptFrameworkRecipe < Playmo::Recipe
      def setup
        question "Please choose JS framework you prefer to install" do
          answer "JQuery (with Jquery UI)"                => :install_jquery
          answer "Mootools Core (with More)"              => :install_mootools
        end
      end

    protected

      # See https://github.com/rails/jquery-rails for detailt
      def install_jquery
        gem "jquery-rails"

        Event.events.listen(:after_install) do |event_data|
          gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
            <<-CONTENT.gsub(/^ {14}/, '')
              //= require jquery
              //= require jquery_ui
              //= require jquery_ujs
              //= require_tree .
            CONTENT
          end
        end
      end

      # See https://github.com/neonlex/mootools-rails for detailt
      def install_mootools
        gem 'mootools-rails'

        Event.events.listen(:after_install) do |event_data|
          gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
            <<-CONTENT.gsub(/^ {14}/, '')
              //= require mootools
              //= require mootools-more
              //= require mootools_ujs
              //= require_tree .
            CONTENT
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/forms_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::FormsRecipe, Playmo::Recipes::JavascriptFrameworkRecipe) if defined?(Playmo::Cookbook)