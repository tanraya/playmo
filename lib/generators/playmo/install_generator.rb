require 'rails/generators/named_base'

module Playmo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a Playmo initializer and copy locale files to your application."
      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        template "application.html.erb", "app/views/layouts/application.html.erb"

        # bundle exec compass init rails -r playmo-rails -u playmo-rails --sass-dir=public/stylesheets --force --trace
        #Rails::Generators.invoke("ead_document", [@document_type.table_name.classify, "--document_type_id=#{@document_type.id}"])

      end
    end
  end
end
