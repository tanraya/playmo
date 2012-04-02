module Playmo
  module Recipe
    def recipe(name, &block)
      Recipe.new(name, &block)
    end

    class Recipe
      attr_accessor :name#, :description, :version

      def initialize(name, &block)
        raise ArgumentError, 'Recipe name not specified' unless name
        raise ArgumentError, 'Block is not specified' unless block_given?

        @name = name
        self.instance_eval &block
      end

      def description(value = nil)
        if value.nil?
          @description
        else
          @description = value
        end
      end

      def version(value = nil)
        if value.nil?
          @version
        else
          @version = value
        end
      end
    end
  end
end