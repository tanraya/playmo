module Rails
  module Generators
    class LayoutGenerator < Base
      desc "Generates layouts for your application."
      source_root File.expand_path('../templates', __FILE__)
      argument :layout_name, :type => :string, :default => 'application'
      argument :markup,      :type => :string, :default => 'erb'

      def generate_layout
        template "layout.html.#{extension}", "app/views/layouts/#{file_name}.html.#{extension}"
      end
     
    private

      def file_name
        layout_name.underscore
      end

      def extension
        extension = markup.downcase
        extension = 'erb' unless ['erb', 'haml', 'slim'].include?(extension)
        extension
      end
    end
  end
end  
