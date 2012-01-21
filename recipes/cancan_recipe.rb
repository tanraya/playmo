recipe :cancan do
  description 'This will add role-based authorization with CanCan'
  after :devise
  
  ask "Would you like to use CanCan in this project?" do
    gem "cancan", "~> 1.6.7"

    # Copy models
    copy_file 'ability.rb', 'app/models/ability.rb'
    copy_file 'role.rb', 'app/models/role.rb'
    copy_file 'user_role.rb', 'app/models/user_role.rb'

    # Create migration
    filename  = "db/migrate/#{(Time.now - 3000).strftime("%Y%m%d%H%M%S")}_create_role_and_user_role.rb"

    create_file filename, <<-CONTENT.gsub(/^ {6}/, '')
      class CreateRoleAndUserRole < ActiveRecord::Migration
        def change
          create_table :roles do |t|
            t.string :name,        :null => false
            t.string :description, :null => false
          end

          add_index :roles, :name, :unique => true

          create_table :user_roles do |t|
            t.integer :role_id, :null => false
            t.integer :user_id, :null => false
          end

          add_index :user_roles, [:role_id, :user_id], :unique => true
        end
      end
    CONTENT

    # Add associations and methods to User
    install do
      gsub_file 'app/models/user.rb', 'cattr_accessor :current' do
        <<-CONTENT.gsub(/^ {10}/, '')
          cattr_accessor :current

          has_many :user_roles
          has_many :roles, :through => :user_roles

          # Check user role
          def role?(role)
            return !!self.roles.find_by_name(role.to_s.camelize)
          end
        CONTENT
      end


      # Add roles into seeds
      gsub_file 'db/seeds.rb', '# Create users' do
        <<-CONTENT.gsub(/^ {10}/, '')
          # Create roles
          admin_role = Role.create!(:name => 'admin', :description => 'Administrator')

          # Create users
        CONTENT
      end

      gsub_file 'db/seeds.rb', 'user.save!' do
        <<-CONTENT.gsub(/^ {10}/, '')
          user.roles << admin_role
          user.save!
        CONTENT
      end

      gsub_file 'db/seeds.rb', 'user2.save!' do
        <<-CONTENT.gsub(/^ {10}/, '')
          user2.roles << admin_role
          user2.save!
        CONTENT
      end
    end
  end
end