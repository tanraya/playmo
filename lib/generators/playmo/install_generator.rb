module Playmo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a Playmo initializer and copy files to your application."
      source_root File.expand_path('../templates', __FILE__)
      attr_accessor :framework

      def generate_controller
        Rails::Generators.invoke("controller", ['home', 'index', '--quiet'])
        
        gsub_file 'app/views/home/index.html.erb', '<h1>Home#index</h1>', :verbose => false do
          '<%= heading_with_title("Home#index") %>'
        end
      end
      
      def remove_rails_files
        remove 'app/controllers/application_controller.rb'
        remove 'app/helpers/application_helper.rb'
        remove 'app/views/layouts/application.html.erb'
        remove 'config/routes.rb'
        remove 'public/favicon.ico'
        remove 'public/robots.txt'
        remove 'public/404.html'
        remove 'public/422.html'
        remove 'public/500.html'
        remove 'public/index.html'
        remove 'public/javascripts/controls.js'
        remove 'public/javascripts/dragdrop.js'
        remove 'public/javascripts/effects.js'
        remove 'public/javascripts/prototype.js'
        remove 'public/javascripts/rails.js'
        remove 'public/images/rails.png'
      end

      def install_js_framework
        say "\nPlease choose JS framework you prefer to install:", :white
        say "\n"
        say "1. JQuery 1.5.1", :white
        say "2. Mootools Core 1.3.1", :white
        say "3. Mootools Core 1.3.1 with More 1.3.1.1", :white

        @framework = ask("\nPlease enter item number:").to_i

        case @framework
        when 1, 0
          copy "jquery/jquery-1.5.1.min.js", "public/javascripts/lib/jquery-1.5.1.min.js"
          copy "jquery/rails.js", "public/javascripts/rails.js"
        when 2
          copy "mootools/mootools-core-1.3.1.js", "public/javascripts/lib/mootools-core-1.3.1.min.js"
          copy "mootools/rails.js", "public/javascripts/rails.js"
        when 3
          copy "mootools/mootools-core-1.3.1.js", "public/javascripts/lib/mootools-core-1.3.1.min.js"
          copy "mootools/rails.js", "public/javascripts/rails.js"
          copy "mootools/mootools-more-1.3.1.1.js", "public/javascripts/lib/mootools-more-1.3.1.1.min.js"
        end
      end
      
      def copy_files
        _template "application.html.erb", "app/views/layouts/application.html.erb"
        _template "routes.rb", "config/routes.rb"
        copy "application_helper.rb", "app/helpers/application_helper.rb"
        copy "application_controller.rb", "app/controllers/application_controller.rb"
      end

      def init_compass
        sass_dir = 'public/stylesheets'
        css_dir  = 'public/stylesheets/compiled'
        using    = 'playmo'
        
        run "compass init rails --quiet -r #{using} -u #{using} --sass-dir=#{sass_dir} \
          --css-dir=#{css_dir}", :verbose => false, :capture => true
      end

      def congrats
        say "\n"
        say "*******************************************************************"
        say "Congratulations! All files has been installed successfully. Playmo!"
        say "You can read some docs on https://github.com/tanraya/playmo"
        say "\n"
      end

    private  
      def app_name  
        RAILS_ROOT.split('/').last.capitalize
      end
      
      def framework
        @framework
      end

      def remove(path)
        remove_file path, :verbose => false
      end

      def copy(from ,to)
        copy_file from ,to, :verbose => false
      end

      def _template(from ,to)
        template from ,to, :verbose => false
      end
    end
  end
end
