module Playmo
  # = Cookbooks
  #
  # TODO Describe what is Cookbook here
  #
  module Cookbook
    def cookbook(name, &block)
      Cookbook.new(name, &block)
    end

    class Cookbook #:nodoc:
      attr_accessor :name, :recipes

      def initialize(name, &block)
        raise ArgumentError, 'Cookbook name not specified' unless name
        raise ArgumentError, 'Block is not specified' unless block_given?

        @name    = name.to_sym
        @recipes = []

        self.instance_eval &block
      end

      def description(value = nil)
        value.nil? ? @description : @description = value
      end

      def recipe(*recipes)
        self.recipes << recipes
        self.recipes.flatten!
      end
    end
  end
end