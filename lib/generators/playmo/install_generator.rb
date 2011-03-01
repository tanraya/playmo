require 'rails/generators/named_base'
require 'compass'
require 'compass/exec'

module Playmo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a Playmo initializer and copy locale files to your application."
      source_root File.expand_path('../templates', __FILE__)
      attr_accessor :js_framework, :mootools_more
      
      def generate_controller
	Rails::Generators.invoke("controller", ['home', 'index'])
      end
      
      def remove_rails_files
	remove_file 'app/views/layouts/application.html.erb'
	remove_file 'config/routes.rb'
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
	if yes? "Would you like to install JQuery (y/n)?"
	  copy_file "jquery/jquery-1.5.1.min.js", "public/javascripts/lib/jquery-1.5.1.min.js"
	  copy_file "jquery/rails.js", "public/javascripts/rails.js"
	  say "JQuery 1.5.1 installed", :green
	  @js_framework = :jquery
	  
	elsif yes? "Would you like to install Mootools (y/n)?"
	  copy_file "mootools/mootools-core-1.3.1.js", "public/javascripts/lib/mootools-core-1.3.1.min.js"
	  copy_file "mootools/rails.js", "public/javascripts/rails.js"
	  say "Mootools Core 1.3.1 installed", :green
	  @js_framework = :mootools
	  
	  if yes? "Would you like to install Mootools More (y/n)?"
	    copy_file "mootools/mootools-more-1.3.1.1.js", "public/javascripts/lib/mootools-more-1.3.1.1.min.js"
	    say "Mootools More 1.3.1.1 installed", :green
	    @mootools_more = true
	  end
	end
      end
      
      def copy_files
        template "application.html.erb", "app/views/layouts/application.html.erb"
	template "routes.rb", "config/routes.rb"
      end

      def init_compass
        # TODO rewrite this
        args = %w{init rails -r playmo-rails -u playmo-rails --sass-dir=public/stylesheets --css-dir=public/stylesheets/compiled --quiet --force}
        command_line_class = Compass::Exec::Helpers.select_appropriate_command_line_ui(args)
        command_line_class.new(args).run!
      end

    private  
      def app_name  
	RAILS_ROOT.split('/').last.capitalize
      end
      
      def js_framework
	@js_framework
      end
      
      def mootools_more?
	@mootools_more
      end
    end
  end
end
