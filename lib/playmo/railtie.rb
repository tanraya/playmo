module Playmo
  class Railtie < Rails::Railtie
    config.app_generators do |g|
      path = File::expand_path('../generators/rails/templates', __FILE__)
      raise path
      g.templates.unshift path
    end 
  end
end 