require 'active_support'

module Playmo
  module Callbacks
    def self.extended(base)
      base.class_eval do
        include ActiveSupport::Callbacks
        define_callbacks :playmo_install
      end

      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def fire(event_name, &block)
        #class_eval do
        #  define_callbacks event_name
        #end

        run_callbacks event_name do
          puts '!'
          block.call
        end
      end

      def before(event_name, &block)
        class_eval do
          set_callback event_name, :before, Proc.new { puts "before" }
        end
      end

      def after(event_name, &block)
        class_eval do
          set_callback event_name, :after, lambda { puts "after" }
        end
      end
    end
  end

  module Generators
    class InstallGenerator
      extend Playmo::Callbacks

      def install
        fire :playmo_install do
          puts "inside playmo_install"
        end

        after :playmo_install do
          puts 'after :playmo_install'
        end

        before :playmo_install do
          puts 'before :playmo_install'
        end
      end
    end
  end
end

Playmo::Generators::InstallGenerator.new.install

