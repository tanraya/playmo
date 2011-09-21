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
end