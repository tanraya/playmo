module Playmo
  module Recipes
    class GitRecipe < Playmo::Recipe
      def setup
        silently do
          Event.events.listen(:before_exit) do |event_data|
            remove_file '.gitignore'

            # TODO Add sphinx & dragonfly files to .gitignore
            create_file '.gitignore', <<-CONTENT.gsub(/^ {14}/, '')
              .DS_Store
              log/*.log
              tmp/**/*
              db/*.sqlite3
              .idea/
              public/uploads/*
              public/assets/*
              .sass-cache/
            CONTENT

            in_root do
              git :init
              git :add    => '.'
              git :commit => "-m 'Initial commit for #{application_name}'"
            end
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/setup_database_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::SetupDatabaseRecipe, Playmo::Recipes::GitRecipe) if defined?(Playmo::Cookbook)
