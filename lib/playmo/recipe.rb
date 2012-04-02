module Playmo
  module Recipe
    def recipe(name, &block)
      Recipe.new(name, &block)
    end

    class Recipe
      attr_accessor :name

      def initialize(name, &block)
        raise ArgumentError, 'Recipe name not specified' unless name
        raise ArgumentError, 'Block is not specified' unless block_given?

        @name = name
        self.instance_eval &block
      end

      def description(value = nil)
        value.nil? ? @description : @description = value
      end

      def version(value = nil)
        value.nil? ? @version : @version = value
      end
    end
  end
end