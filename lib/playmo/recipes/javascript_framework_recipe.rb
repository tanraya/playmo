module Playmo
  module Recipes
    class JavascriptFrameworkRecipe < Playmo::Recipe
      def setup
        question "Please choose JS framework you prefer to install" do
          answer "JQuery (with Jquery UI)"                => :install_jquery
          answer "Mootools Core (with More)"              => :install_mootools
          answer "Prototype (with Scriptaculous and RJS)" => :install_prototype
        end
      end

    protected

      # See https://github.com/rails/jquery-rails for detailt
      def install_jquery
        gem "jquery-rails"

        Event.events.listen(:after_install) do |event_data|
          gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
            <<-CONTENT.gsub(/^ {16}/, '')
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
            <<-CONTENT.gsub(/^ {16}/, '')
              //= require mootools
              //= require mootools-more
              //= require mootools_ujs
              //= require_tree .
            CONTENT
          end
        end
      end

      # See https://github.com/rails/prototype-rails for details
      def install_prototype
        gem "prototype-rails"

        Event.events.listen(:after_install) do |event_data|
          gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
            <<-CONTENT.gsub(/^ {16}/, '')
              //= require prototype
              //= require prototype_ujs
              //= require effects
              //= require dragdrop
              //= require controls
              //= require_tree .
            CONTENT
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::JavascriptFrameworkRecipe) if defined?(Playmo::Cookbook)