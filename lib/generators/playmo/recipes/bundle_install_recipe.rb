module Playmo
  module Generators
    module Recipes
      class BundleInstallRecipe < Playmo::Recipe
        def setup
          gem "devise"
          run "bundle install"

=begin
          silently do
            Event.events.listen(:after_install) do

              Event.events.fire :before_bundle_install

              in_root do
                run "bundle install"
              end

              Event.events.fire :after_bundle_install
            end
            
          end
=end

        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
#puts "BundleInstallRecipe"
#Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::BundleInstallRecipe) if defined?(Playmo::Cookbook)
