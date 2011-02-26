require 'rails/generators/named_base'
require 'compass'
require 'compass/exec'

module Playmo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a Playmo initializer and copy locale files to your application."
      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        template "application.html.erb", "app/views/layouts/application.html.erb"
      end

      def remove_rails_files
        remove_file 'public/404.html'
        remove_file 'public/422.html'
        remove_file 'public/500.html'
        remove_file 'public/index.html'
        remove_file 'public/controls.js'
        remove_file 'public/dragdrop.js'
        remove_file 'public/effects.js'
        remove_file 'public/prototype.js'
      end

      def init_compass
        # TODO rewrite this
        args = %w{init rails -r playmo-rails -u playmo-rails --sass-dir=public/stylesheets --css-dir=public/stylesheets/compiled --force --trace}
        command_line_class = Compass::Exec::Helpers.select_appropriate_command_line_ui(args)
        command_line_class.new(args).run!
      end

      #Rails::Generators.invoke("ead_document", [@document_type.table_name.classify, "--document_type_id=#{@document_type.id}"])
    end
  end
end
