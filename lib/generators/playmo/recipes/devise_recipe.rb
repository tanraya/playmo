module Playmo
  module Generators
    module Recipes
      class DeviseRecipe < Playmo::Recipe
        def setup
          question "Would you like to use Devise in this project?" => :install_devise
        end

        def install_devise
          Event.events.listen(:after_install) do |event_data|
            puts "after_install yay"
          end

          #Playmo::Event.events.listen(:before_bundle_install) do |event_data|
            gem "devise", "1.4.7"

          Event.events.listen(:after_install) do
            Event.events.listen(:after_bundle_install) do
              run "bundle"
            end
          end
=begin

          Playmo::Event.events.listen(:after_bundle_install) do |event_data|
            # Generate Devise stuff
            generate "devise:install"
            generate "devise User"
            generate "devise:views"

            # Add :name accessor to default accessors
            # Also add some specific methods
            gsub_file 'app/models/user.rb', ' attr_accessible :email, :password, :password_confirmation, :remember_me', :verbose => false do
              <<-CONTENT.gsub(/^ {16}/, '')
                attr_accessible :email, :password, :password_confirmation, :remember_me, :name
                cattr_accessor :current

                # Return user name or user name from email address
                def username
                  name.blank? ? email.match(/^[^@]+/)[0] : name
                end
              CONTENT
            end
          end

          # Create migration that adds name field to users table
          timestamp = Time.now.strftime("%Y%m%d%H%M%S")
          filename  = "db/migrate/#{timestamp}_add_name_to_users.rb"

          create_file filename, <<-CONTENT.gsub(/^ {12}/, '')
            class AddNameToUsers < ActiveRecord::Migration
              def change
                add_column :users, :name, :string
              end
            end
          CONTENT

          # Create default user
          append_to_file 'db/seeds.rb' do
            <<-CONTENT.gsub(/^ {12}/, '')
              user = User.create!(
                :email                 => 'johndoe@example.com',
                :password              => 'secret',
                :password_confirmation => 'secret'
              )
            CONTENT
          end
=end
          
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
puts "DeviseRecipe"
Playmo::Cookbook.instance.use(Playmo::Generators::Recipes::DeviseRecipe) if defined?(Playmo::Cookbook)
