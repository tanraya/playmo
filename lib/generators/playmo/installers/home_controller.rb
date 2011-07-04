module Playmo
  module Generators
    module Installers
      class HomeController < Base
        def setup
          question "Do you want to create HomeController in this project?" => :create_home_controller
        end

      protected

        def create_home_controller
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
                <h3>Sidebar</h3>
                <p>Content for sidebar.</p>
                <p>This content displayed only at home page.</p>
              <% end %>
            CONTENT
          end
        end
      end
    end
  end
end