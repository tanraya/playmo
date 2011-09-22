module Playmo
  module Generators
    module Recipes
      class HomeControllerRecipe < Playmo::Recipe
        # Cook the recipe
        # TODO: Add rspec tests
        # TODO: Recipe with more than one question
        # TODO: You can create own gem and redefine Playmo behavior by removing or adding recipes
        # TODO: Create a web service built on top of Playmo to prepare new app and putting it to Github or download in archive
        # TODO: A playmo bin file that generate rails app and do all the stuff as altennative to manually installing rails app and include playmo into this app
        # TODO: Require playmo to the app only when in development mode
        # TODO: Copy Playmo view heplers into the app
=begin
        silently do
          # do something without any questions
        end

        question "What's up Doc?" => :do_something_for_doc

        def do_something_for_doc
          # do something for Doc
        end

        question "What's up Doc?" do
          answer "So-so" => :so_so
          answer "Nice!" => :nice
        end

        question "What's up Doc?" do
          answer "So-so" do
            # do something
          end

          answer "Nice!" do
            # do something
          end
        end
=end
        question "Do you want to create HomeController in this project?" => :install

        def install
          # Нужно подписывать этот рецепт на событие playmo_install
          #Playmo::Event.events.listen(:after_playmo_install) do |event_data|
          #  puts "after_playmo_install"
          #end

          #Playmo::Event.events.listen(:before_playmo_install) do |event_data|
          #  puts "before_playmo_install"
          #end

          # Generate home_controller
          generate :controller, :home, :index

          # Change generated routes
          gsub_file 'config/routes.rb', 'get "home/index"' do
            'root :to => "home#index"'
          end

          # Make changes in index view
          gsub_file 'app/views/home/index.html.erb', '<h1>Home#index</h1>' do
            <<-CONTENT.gsub(/^ {12}/, '')
              <%= heading_with_title("Home#index") %>

              <% content_for :sidebar do %>
                <%= heading "Sidebar" %>
                <p>Content for sidebar.</p>
                <p>This content displayed only at home page.</p>
              <% end %>
            CONTENT
          end

          # Remove default rails index file
          remove_file 'public/index.html'
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::HomeControllerRecipe.new) if defined?(Playmo::Cookbook)
