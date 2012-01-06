require 'thor/group'
require 'thor/shell/color'
require 'thor/shell/basic'

trap("SIGINT") { print "\n"; exit! }

module Playmo
  class Cli < Thor::Group
    include Thor::Actions
    
    class_option 'dry-run', :aliases => "-d", :default => false, :desc => "Run without making any modifications on files"
    
    # TODO: Use internal shell variable
    def new_app
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

  end
end