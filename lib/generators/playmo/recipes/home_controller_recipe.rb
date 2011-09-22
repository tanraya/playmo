module Playmo
  module Generators
    module Recipes
      class HomeControllerRecipe < Playmo::Recipe
        def setup
          question "Do you want to create HomeController in this project?" => :install_home_controller
        end

        def install_home_controller
          # Нужно подписывать этот рецепт на событие playmo_install
          Playmo::Event.events.listen(:after_playmo_install) do |event_data|
            puts "after_playmo_install"
          end

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
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::HomeControllerRecipe) if defined?(Playmo::Cookbook)
