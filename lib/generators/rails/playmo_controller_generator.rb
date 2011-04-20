require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class PlaymoControllerGenerator < ScaffoldControllerGenerator
      source_root File.expand_path("../templates", __FILE__)
    end
  end
end
