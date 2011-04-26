require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class ScaffoldControllerGenerator < ScaffoldControllerGenerator
      source_root File.expand_path("../templates", __FILE__)

      def create_controller_files
        template 'scaffold_controller.rb', File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
      end
    end
  end
end
