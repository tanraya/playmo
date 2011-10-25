module Playmo
  module Recipes
    class DeviseRecipe < Playmo::Recipe
      source_root File.expand_path('../templates/devise_recipe', __FILE__)

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

          # Add :name accessor to default accessors
          # Also add some specific methods
          gsub_file 'app/models/user.rb', 'attr_accessible :email, :password, :password_confirmation, :remember_me' do
            <<-CONTENT.gsub(/^ {12}/, '')
              attr_accessible :email, :password, :password_confirmation, :remember_me, :name
              cattr_accessor :current
              
              # Return user name or user name from email address
              def username
                name.blank? ? email.match(/^[^@]+/)[0] : name
              end
            CONTENT
          end

          # Add links into layout
          gsub_file 'app/views/layouts/application.html.erb', '</header>' do
            <<-CONTENT.gsub(/^ {12}/, '')
                <div id="user-info">
                  <ul>
                    <% if user_signed_in? %>
                      <li>
                        Hello, Dear <strong><%= current_user.username %></strong>!
                        Maybe, you want to <%= link_to 'logout', destroy_user_session_path %>?
                      </li>
                    <% else %>
                      <li>
                        Hello Guest, maybe you want to <%= link_to 'Join us', new_user_registration_path %> or <%= link_to 'login', new_user_session_path %>?
                      </li>
                    <% end %>
                  </ul>
                </div>
              </header>
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
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/layout_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::LayoutRecipe, Playmo::Recipes::DeviseRecipe) if defined?(Playmo::Cookbook)
