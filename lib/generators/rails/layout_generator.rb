module Rails
  module Generators
    class LayoutGenerator < Base
      desc "Generates layouts for your application."
      source_root File.expand_path('../templates', __FILE__)
      argument :layout_name, :type => :string, :default => "application"

      def generate_layout
        template "layout.html.erb", "app/views/layouts/#{file_name}.html.erb"
      end
     
    private

      def file_name
        layout_name.underscore
      end
    end
  end
end  
