module Playmo
  module Recipes
    class DeviseRecipe < Playmo::Recipe
      def setup
        question "Would you like to use Devise in this project?" => :install_devise
      end

      def install_devise
        gem 'devise'

        Event.events.listen(:after_install) do |event_data|
          # Generate Devise stuff
          generate "devise:install"
          generate "devise User"
          generate "devise:views"

          # Add sign_up/login links into layout
          add_layout_links

          # Process Devise views to choosen markup
          process_views

          # Add :name accessor to default accessors
          # Also add some specific methods
          gsub_file 'app/models/user.rb', '  attr_accessible :email, :password, :password_confirmation, :remember_me' do
            <<-CONTENT.gsub(/^ {12}/, '')
              attr_accessible :email, :password, :password_confirmation, :remember_me, :name
              cattr_accessor :current
              
              # Return user name or user name from email address
              def username
                name.blank? ? email.match(/^[^@]+/)[0] : name
              end
            CONTENT
          end

          # Create migration that adds name field to users table
          filename  = "db/migrate/#{(Time.now - 3600).strftime("%Y%m%d%H%M%S")}_add_name_to_users.rb"

          create_file filename, <<-CONTENT.gsub(/^ {12}/, '')
            class AddNameToUsers < ActiveRecord::Migration
              def change
                add_column :users, :name, :string
              end
            end
          CONTENT
        end

        # Create default user
        append_to_file 'db/seeds.rb' do
          <<-CONTENT.gsub(/^ {12}/, '')
            user = User.create!(
              :email                 => 'johndoe@example.com',
              :password              => 'secret',
              :password_confirmation => 'secret'
            )

            user2 = User.create!(
              :email                 => 'annadoe@example.com',
              :password              => 'secret',
              :password_confirmation => 'secret'
            )
          CONTENT
        end

      end

    private

      # Add links into layout
      def add_layout_links
        case retrieve(:markup)
          when :erb  then create_userbar_with_erb
          when :haml then create_userbar_with_haml
          when :slim then create_userbar_with_slim
        end
      end

      # Process Devise views to choosen markup
      def process_views
        case retrieve(:markup)
          when :haml then process_views_with_haml
          when :slim then process_views_with_slim
        end
      end

      def create_userbar_with_erb
        gsub_file 'app/views/layouts/application.html.erb', '      </header>' do
          <<-CONTENT.gsub(/^ {6}/, '')
              <%= render 'shared/userbar' %>
            </header>
          CONTENT
        end

        create_file 'app/views/shared/_userbar.html.erb' do
          <<-CONTENT.gsub(/^ {12}/, '')
            <div id="user-info">
              <ul>
                <% if user_signed_in? %>
                  <li>
                    Hello, Dear <strong><%= current_user.username %></strong>!
                    Maybe, you want to <%= link_to 'logout', main_app.destroy_user_session_path, :method => :delete %>?
                  </li>
                <% else %>
                  <li>
                    Hello Guest, maybe you want to <%= link_to 'Join us', main_app.new_user_registration_path %> or <%= link_to 'login', main_app.new_user_session_path %>?
                  </li>
                <% end %>
              </ul>
            </div>
          CONTENT
        end
      end

      def create_userbar_with_haml
        gsub_file 'app/views/layouts/application.html.haml', '      #body' do
          <<-CONTENT.gsub(/^ {6}/, '')
              = render 'shared/userbar'
            #body
          CONTENT
        end

        create_file 'app/views/shared/_userbar.html.haml' do
          <<-'CONTENT'.gsub(/^ {12}/, '')
            #user-info
              %ul
                - if user_signed_in?
                  %li
                    Hello, Dear
                    = succeed "!" do
                      %strong= current_user.username
                    Maybe, you want to #{link_to 'logout', main_app.destroy_user_session_path, :method => :delete}?
                - else
                  %li
                    Hello Guest, maybe you want to #{link_to 'Join us', main_app.new_user_registration_path} or #{link_to 'login', main_app.new_user_session_path}?
          CONTENT
        end
      end

      def create_userbar_with_slim
        gsub_file 'app/views/layouts/application.html.slim', '      #body' do
          <<-'CONTENT'.gsub(/^ {6}/, '')
              = render 'shared/userbar'
            #body
          CONTENT
        end

        create_file 'app/views/shared/_userbar.html.slim' do
          <<-'CONTENT'.gsub(/^ {12}/, '')
            #user-info
              ul
                - if user_signed_in?
                  li
                    ' Hello, Dear
                    strong= current_user.username
                    ' ! Maybe, you want to #{link_to 'logout', main_app.destroy_user_session_path, :method => :delete}?
                - else
                  li
                    | Hello Guest, maybe you want to #{link_to 'Join us', main_app.new_user_registration_path} or #{link_to 'login', main_app.new_user_session_path}?  
          CONTENT
        end
      end

      def process_views_with_haml
        Dir["#{destination_root}/app/views/devise/**/*.erb"].each do |erb_file|
          haml_file = erb_file.gsub(/\.erb$/, '.haml')
          run "html2haml #{erb_file} #{haml_file}"
          run "rm #{erb_file}"
        end
      end

      def process_views_with_slim
        process_views_with_haml

        Dir["#{destination_root}/app/views/devise/**/*.haml"].each do |haml_file|
          slim_file = haml_file.gsub(/\.haml$/, '.slim')
          run "haml2slim #{haml_file} #{slim_file}"
          run "rm #{haml_file}"
        end
      end

    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/layout_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::LayoutRecipe, Playmo::Recipes::DeviseRecipe) if defined?(Playmo::Cookbook)
