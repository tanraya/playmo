module Playmo
  module Generators
    module Recipes
      class GitRecipe < Playmo::Recipe
        def setup
          silently do
            Event.events.listen(:after_install) do |event_data|
              remove_file '.gitignore'

              create_file '.gitignore', <<-CONTENT.gsub(/^ {16}/, '')
                .DS_Store
                log/*.log
                tmp/**/*
                db/*.sqlite3
                .idea/
                public/uploads/*
                .sass-cache/
              CONTENT

              git :init
              git :submodule => "init"
              git :add       => '.'
              git :commit    => "-am 'Initial commit for #{application_name}'"
            end
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::GitRecipe) if defined?(Playmo::Cookbook)
