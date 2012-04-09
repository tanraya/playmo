module Playmo
  # = Recipes
  #
  # TODO Describe what is Recipe here
  #
  module Recipe
    # Factory
    # TODO Rename to .build
    def recipe(name, &block)
      Recipe.new(name, &block)
    end

    class Recipe #:nodoc:
      attr_accessor :name

      def initialize(name, &block)
        raise ArgumentError, 'Recipe name not specified' unless name
        #raise ArgumentError, 'Block is not specified' unless block_given?

        @name = name.to_s
        setup_block(&block) if block_given?
      end

      def setup_block(&block)
        self.instance_eval(&block)
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