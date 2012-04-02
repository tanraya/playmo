module Playmo
  # = Cookbooks
  #
  # TODO Descripe what is Cookbook here
  #
  module Cookbook
    def cookbook(name, &block)
      Cookbook.new(name, &block)
    end

    class Cookbook #:nodoc:
      attr_accessor :name

      def initialize(name, &block)
        raise ArgumentError, 'Cookbook name not specified' unless name
        raise ArgumentError, 'Block is not specified' unless block_given?

        @name = name
        self.instance_eval &block
      end

      def description(value = nil)
        value.nil? ? @description : @description = value
      end
    end
  end
end