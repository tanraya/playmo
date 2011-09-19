module Playmo
  module Generators
    module Recipes
      class BundleInstallRecipe < Playmo::Recipe
        silently do
          # After all recipes was cooked
          after :playmo_install do # Этот блок выполняется отложенно
            # Fires the 'bundle_install' event to notify subscribers
            fire :bundle_install do
              # And run command
              run 'bundle install'
            end
          end
        end
      end
    end
  end
end