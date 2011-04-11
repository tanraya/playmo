module Playmo
  module Generators
    #extend Rails::Generators::AppGenerator
    
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a Playmo initializer and copy files to your application."
      source_root File.expand_path('../templates', __FILE__)
      attr_accessor :framework

      def use_gems
        gem "devise", "~> 1.2.0"
        gem "cancan"
        gem "compass"
      end

      def generate_home_controller
        generate :controller, :home, :index, '--quiet'
        
        gsub_file 'app/views/home/index.html.erb', '<h1>Home#index</h1>', :verbose => false do
          '<%= heading_with_title("Home#index") %>'
        end
      end
      
      def remove_rails_files
        remove_file 'app/controllers/application_controller.rb'
        remove_file 'app/helpers/application_helper.rb'
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
      
      def copy_files
        template "application.html.erb", "app/views/layouts/application.html.erb"
        copy_file "application_helper.rb", "app/helpers/application_helper.rb"
        copy_file "application_controller.rb", "app/controllers/application_controller.rb"
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

      def initialize_compass
        sass_dir = 'public/stylesheets'
        css_dir  = 'public/stylesheets/compiled'
        using    = 'playmo'
        
        run "compass init rails --quiet -r #{using} -u #{using} --sass-dir=#{sass_dir} \
          --css-dir=#{css_dir}", :verbose => false, :capture => true
      end

      def congrats
        say "\n"
        say "*******************************************************************"
        say "Congratulations! All files has been installed successfully."
        say "You can read some docs on https://github.com/tanraya/playmo"
        say "\n"
      end
    end
  end
end
