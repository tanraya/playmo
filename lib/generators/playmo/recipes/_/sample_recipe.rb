module Playmo
  module Generators
    module Recipes
      class SampleRecipe < Playmo::Recipe
        # Cook the recipe
        # TODO: Add rspec tests
        # TODO: Recipe with more than one question
        # TODO: You can create own gem and redefine Playmo behavior by removing or adding recipes
        # TODO: Create a web service built on top of Playmo to prepare new app and putting it to Github or download in archive
        # TODO: A playmo bin file that generate rails app and do all the stuff as altennative to manually installing rails app and include playmo into this app
        # TODO: Require playmo to the app only when in development mode
        # TODO: Copy Playmo view heplers into the app

        def initialize
          silently do
            # do something without any questions
          end

          question "What's up Docz?" => :do_something_for_doc

          def do_something_for_doc
            # do something for Doc
          end

          question "What's up Docx?" do
            answer "So-so" => :so_so
            answer "Nice!" => :nice
          end

          question "What's up Docy?" do
            answer "So-so" do
              # do something
            end

            answer "Nice!" do
              # do something
            end
          end
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
# Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::SampleRecipe.new) if defined?(Playmo::Cookbook)
