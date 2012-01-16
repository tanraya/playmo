require 'thor/group'
require 'thor/shell/color'
require 'thor/shell/basic'

trap("SIGINT") { print "\n"; exit! }

module Playmo
  class Cli < Thor::Group
    include Thor::Actions
    
    class_option 'dry-run', :aliases => "-d", :default => false, :desc => "Run without making any modifications on files"
    class_option 'require', :aliases => "-r", :default => false, :desc => "Require gem that contains custom recipes"
    
    # TODO: Use internal shell variable
    def new_app
      require_gem

      color = Thor::Shell::Color.new
      shell = Thor::Shell::Basic.new
      shell.padding = 1

      shell.say("\n")

      if application_name = shell.ask(color.set_color('Please enter the name of app you want to create:', :yellow, true))
        Playmo::Cookbook.instance.cook_recipes!(application_name, options)
      end

      shell.say("\n")

      system "cd #{application_name} && bundle install"

      Event.events.fire :after_install
      Event.events.fire :before_exit
    end

  private

    def require_gem
      return unless options[:require]
      gem options[:require]
      #load '/home/tanraya/sandbox/tanraya-playmo/lib/tanraya-playmo.rb'
      #require 'rubygems'
      #gem 'tanraya-playmo', :path => '../../../'
    end

  end
end