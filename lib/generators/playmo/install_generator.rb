require 'active_support'
require "#{File.dirname(__FILE__)}/installers/base"

module Playmo
  module Generators
    INSTALLERS = [
      :JavascriptFramework,
      :HomeController,
      :Html5Support,
#      :DefaultUser,
      #:Compass,
#      :Capistrano,
#      :Git,
      #:Rvm (Проверять, есть ли rvm на машине, устанавливает .rvmrc, создает гемсет)
    ]

    # TODO:
    # - Создать систему хуков, чтобы можно было выполнять отложенные задачи из инсталлера
    # - Поддержка инсталлеров, которые не задают вопросов
    # - При запуске генератора рисовать кол-во вопросов и небольшое вступление
    # - Убрать source_root отсюда
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "Creates a Playmo initializer and copy files to your application."
   
      def install
        INSTALLERS.each do |installer|
          require "#{File.dirname(__FILE__)}/installers/#{installer.to_s.underscore}"

          # Setup installer
          installer = Installers.const_get(installer).new
          installer.setup

          q = installer.question_instance

          # Ask question
          q.ask_question!

          # Ask for choice and make choice
          q.choice.make_choice!
        end
      end
    end
  end
end









=begin
module Playmo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      #JsFrameworkGenerator.install

      desc "Creates a Playmo initializer and copy files to your application."
      source_root File.expand_path('../templates', __FILE__)
      attr_accessor :framework

      def use_gems
        gem "devise", "~> 1.3.1"
        gem "cancan", "~> 1.6.4"
        gem "compass", "~> 0.10.6", :group => :development
	gem "jammit", "~> 0.6.0"

        gsub_file 'Gemfile', "# gem 'capistrano'", :verbose => false do
          "gem 'capistrano'"
        end
      end

      def generate_home_controller
        generate :controller, :home, :index

        gsub_file 'app/views/home/index.html.erb', '<h1>Home#index</h1>', :verbose => false do
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

      def remove_rails_files
        remove_file '.gitignore'
        remove_file 'app/controllers/application_controller.rb'
        remove_file 'app/views/layouts/application.html.erb'
        remove_file 'public/favicon.ico'
        remove_file 'public/robots.txt'
        remove_file 'public/404.html'
        remove_file 'public/422.html'
        remove_file 'public/500.html'
        remove_file 'public/index.html'
        remove_file 'public/javascripts/controls.js'
        remove_file 'public/javascripts/dragdrop.js'
        remove_file 'public/javascripts/effects.js'
        remove_file 'public/javascripts/prototype.js'
        remove_file 'public/javascripts/rails.js'
        remove_file 'public/images/rails.png'
	run 'touch README'
      end

      def install_js_framework
        say "\nPlease choose JS framework you prefer to install:", :white
        say "\n"
        say "1. JQuery 1.5.2", :white
        say "2. Mootools Core 1.3.1", :white
        say "3. Mootools Core 1.3.1 with More 1.3.1.1", :white

        @framework = ask("\nPlease enter item number:").to_i

        case @framework
        when 1, 0
          copy_file "jquery/jquery-1.5.2.min.js", "public/javascripts/lib/jquery-1.5.2.min.js"
          copy_file "jquery/rails.js", "public/javascripts/rails.js"
        when 2
          copy_file "mootools/mootools-core-1.3.1.js", "public/javascripts/lib/mootools-core-1.3.1.min.js"
          copy_file "mootools/rails.js", "public/javascripts/rails.js"
        when 3
          copy_file "mootools/mootools-core-1.3.1.js", "public/javascripts/lib/mootools-core-1.3.1.min.js"
          copy_file "mootools/rails.js", "public/javascripts/rails.js"
          copy_file "mootools/mootools-more-1.3.1.1.js", "public/javascripts/lib/mootools-more-1.3.1.1.min.js"
        end
      end

      def create_uploads_dir
        run "mkdir public/uploads && chmod 777 public/uploads"
      end

      def create_shared_folder
        empty_directory "app/views/shared"
      end

      def copy_files
        #template "application.html.erb", "app/views/layouts/application.html.erb"
        copy_file "application_controller.rb", "app/controllers/application_controller.rb"
        copy_file "_sidebar.html.erb", "app/views/shared/_sidebar.html.erb"
      end

      def generate_application_layout
        generate :layout
      end

      def setup_routes
	route 'root :to => "home#index"'
        gsub_file 'config/routes.rb', 'get "home/index"', :verbose => false do
          ''
        end
      end

      def run_gems_generators
        generate "devise:install"
        generate "devise User"
        generate "devise:views"
        generate "cancan:ability"

        # Add :name accessor to default accessors
        # Also add some specific methods
        gsub_file 'app/models/user.rb', '  attr_accessible :email, :password, :password_confirmation, :remember_me', :verbose => false do
          <<-CONTENT.gsub(/^ {10}/, '')
            attr_accessible :email, :password, :password_confirmation, :remember_me, :name
            cattr_accessor :current

            # Return user name or user name from email address
            def username
              name.blank? ? email.match(/^[^@]+/)[0] : name
            end
          CONTENT
        end
      end

      def add_name_to_users_table
        timestamp = Time.now.strftime("%Y%m%d%H%M%S")
        filename  = "db/migrate/#{timestamp}_add_name_to_users.rb"

        create_file filename, <<-CONTENT.gsub(/^ {10}/, '')
          class AddNameToUsers < ActiveRecord::Migration
            def self.up
              add_column :users, :name, :string
            end

            def self.down
              remove_column :users, :name
            end
          end
        CONTENT
      end

      def initialize_compass
        sass_dir = 'public/stylesheets'
        css_dir  = 'public/assets/compiled/stylesheets'
        using    = 'playmo'

        run "compass init rails --quiet -r #{using} -u #{using} --sass-dir=#{sass_dir} \
          --css-dir=#{css_dir}", :verbose => false, :capture => true

        append_to_file 'config/compass.rb' do
          'output_style = :compact'
        end
      end

      def copy_tasks
	copy_file "tasks/sass.rake", "lib/tasks/sass.rake"
	copy_file "tasks/assets.rake", "lib/tasks/assets.rake"
      end

      def copy_assets_config
	template "assets.yml", "config/assets.yml"
      end

      def capify
	capify!
	remove_file 'config/deploy.rb'
	copy_file "deploy.rb", "config/deploy.rb"
      end

      def add_default_user
        append_to_file 'db/seeds.rb' do
          <<-CONTENT.gsub(/^ {12}/, '')
            User.create!(
              :email                 => 'johndoe@example.com',
              :password              => 'secret',
              :password_confirmation => 'secret'
            )
          CONTENT
        end
      end

      def setup_git_repo
	create_file '.gitignore', <<-CONTENT.gsub(/^ {10}/, '')
          .DS_Store
          log/*.log
          tmp/**/*
          db/*.sqlite3
          nbproject/
          .idea/
          public/uploads/*
	CONTENT

	git :init
	git :submodule => "init"
	git :add       => '.'
	git :commit    => "-am 'Initial commit'"
      end

      # Move all migrations into schema.rb and run db:setup instead of this code
      def setup_database
        rake("db:create")
        rake("db:migrate")
        rake("db:seed")
      end

      def congrats
        say "\n"
        say "*******************************************************************"
        say "Congratulations! All files has been installed successfully."
        say "You can read some docs on https://github.com/tanraya/playmo"
	say "\n"
	say "Don't forget to configure config/initializers/devise.rb and config/deploy.rb!"
        say "\n"
      end

    private

      def framework
	@framework
      end

    end
  end
end
=end