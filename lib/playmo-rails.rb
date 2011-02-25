Compass::Frameworks.register("playmo-rails", :path => "#{File.dirname(__FILE__)}/..")

if defined?(ActionController)
  require File.join(File.dirname(__FILE__), 'app', 'helpers', 'playmo_rails_helper')
  ActionController::Base.helper(PlaymoRailsHelper)
end
