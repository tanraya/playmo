module Playmo
  module Generators
    module Recipes
      class GitRecipe < Playmo::Recipe
        def setup
          question "Create git repo for your app?" => :create_git_repo
        end

        def create_git_repo
          Playmo::Event.events.listen(:after_playmo_install) do |event_data|
            remove_file '.gitignore'

            create_file '.gitignore', <<-CONTENT.gsub(/^ {14}/, '')
              .DS_Store
              log/*.log
              tmp/**/*
              db/*.sqlite3
              .idea/
              public/uploads/*
              .bundle
              .sass-cache/
            CONTENT

            git :init
            git :submodule => "init"
            git :add       => '.'
            git :commit    => "-am 'Initial commit'"
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::GitRecipe) if defined?(Playmo::Cookbook)
