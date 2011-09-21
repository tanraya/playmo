require 'active_support'

module Playmo
  module Callbacks
    def self.included(base)
      base.class_eval do
        include ActiveSupport::Callbacks
        alias :fire :run_callbacks
      end
    end

    def method_missing(m, *args, &block)
      raise NoMethodError unless [:before, :after].include?(m)
      event = args.first

      class_eval do
        define_callbacks(event) unless respond_to? "_#{event}_callbacks"

        set_callback event, m do
          block.call
        end
      end
    end
  end

  class SampleRecipe
    
  end

  class Installer
    include Callbacks

    def save
      before :save do
        puts "before_save block is called"
      end

      after :save do
        puts "after_save block is called"
      end
      
      fire :save do
        puts 'save'
      end
    end
  end
end

Playmo::Installer.new.save
