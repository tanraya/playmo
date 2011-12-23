require 'thor/group'

module Playmo
  class Cli < Thor::Group
    include Thor::Actions
    
    argument :application_name, :type => :string, :desc => "The name of the rails application"
    desc "Generates a new Rails application with Playmo'"

    def run_playmo
      self.destination_root = application_name
      system "rails new #{application_name} -JT --skip-bundle"
      
      Playmo::Cookbook.instance.cook_recipes!(application_name)

      system %Q{echo "gem 'therubyracer'" >> ./#{application_name}/Gemfile}
      system %Q{echo "gem 'playmo', :group => :development" >> ./#{application_name}/Gemfile}
      system "cd #{application_name} && bundle install"

      Event.events.fire :after_install
      Event.events.fire :before_exit
    end

  end
end