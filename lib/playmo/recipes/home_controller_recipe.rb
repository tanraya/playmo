=begin

class HomeControllerRecipe < Playmo::Recipe::Recipe
  def initialize(*args)
    super(*args)

    # Generate home_controller
    after_install do
      generate :controller, :home, :index

      # Change generated routes
      gsub_file 'config/routes.rb', 'get "home/index"' do
        'root :to => "home#index"'
      end

      # Make changes in index view
      change_index_view

      # Copy sidebar template
      empty_directory "app/views/shared"
      copy_file "_sidebar.html.erb", "app/views/shared/_sidebar.html.erb"

      # Remove default rails index file
      remove_file 'public/index.html'
    end
  end

private

  # Make changes in index view
  def change_index_view
    case retrieve(:markup)
      when :erb  then change_index_view_with_erb
      when :haml then change_index_view_with_haml
      when :slim then change_index_view_with_slim
    end
  end

  def change_index_view_with_erb
    gsub_file 'app/views/home/index.html.erb', '<h1>Home#index</h1>' do
      <<-CONTENT.gsub(/^ {8}/, '')
        <%= heading_with_title("Home#index") %>

        <% content_for :sidebar do %>
          <%= heading "Sidebar" %>
          <p>Content for sidebar.</p>
          <p>This content displayed only at home page.</p>
        <% end %>
      CONTENT
    end
  end

  def change_index_view_with_haml
    gsub_file 'app/views/home/index.html.haml', '%h1 Home#index' do
      <<-'CONTENT'.gsub(/^ {8}/, '')
        = heading_with_title("Home#index")
        - content_for :sidebar do
          = heading "Sidebar"
          %p Content for sidebar.
          %p This content displayed only at home page.
      CONTENT
    end
  end
  
  def change_index_view_with_slim
    gsub_file 'app/views/home/index.html.slim', 'h1 Home#index' do
      <<-'CONTENT'.gsub(/^ {8}/, '')
        = heading_with_title("Home#index")
        - content_for :sidebar do
          = heading "Sidebar"
          p Content for sidebar.
          p This content displayed only at home page.
      CONTENT
    end
  end
end
=end
recipe :home_controller do
  description 'Something'
  after :layout

  ask "Would you want to create HomeController in this project?" do
    #HomeControllerRecipe.new
  end
end