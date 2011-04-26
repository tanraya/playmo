require 'rails/generators/rails/controller/controller_generator'

lass Rails::Generators::ControllerGenerator
  (class << self; self; end).class_eval { source_root File.expand_path("../templates", __FILE__) }
end
