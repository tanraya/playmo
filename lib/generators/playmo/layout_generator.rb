module Playmo
  module Generators
    class LayoutGenerator < Rails::Generators::Base
      desc "Generates layouts for your application."
      source_root File.expand_path('../templates', __FILE__)  
      argument :layout_name, :type => :string, :default => "application"  
    end
  end
end  
