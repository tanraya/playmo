module Playmo
  module Recipes
    class HomeControllerRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/home_controller_recipe', __FILE__)

      def setup
        question "Do you want to create HomeController in this project?" => :install_home_controller
      end

      def install_home_controller
        # Generate home_controller
        Event.events.listen(:after_install) do |event_data|
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

        # Copy sidebar template
        empty_directory "app/views/shared"
        copy_file "_sidebar.html.erb", "app/views/shared/_sidebar.html.erb"

        # Remove default rails index file
        remove_file 'public/index.html'
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
Playmo::Cookbook.instance.use(Playmo::Recipes::HomeControllerRecipe) if defined?(Playmo::Cookbook)