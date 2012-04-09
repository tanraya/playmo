module Playmo
  # = Cookbooks
  #
  # TODO Describe what is Cookbook here
  #
  module Cookbook
    # Factory
    # TODO Rename to .build
    def cookbook(name, &block)
      Cookbook.new(name, &block)
    end

    class Cookbook #:nodoc:
      attr_accessor :name, :recipes

      def initialize(name, &block)
        raise ArgumentError, 'Cookbook name not specified' unless name
        raise ArgumentError, 'Block is not specified' unless block_given?

        @name    = name.to_s
        @recipes = []

        self.instance_eval &block
      end

      def description(value = nil)
        value.nil? ? @description : @description = value
      end

      # TODO Cleanup the code
      def recipe(*recipes, &block)
        if recipes.size == 1
          recipe = recipes.first

          case recipe
          when String, Symbol
            recipe = Playmo::Recipe::Recipe.new(recipe)
            recipe.setup_block(&block) if block_given?
          else
            recipe.setup_block(&block) if block_given?
          end
          
          self.recipes << recipe
        elsif recipes.size > 1
          self.recipes << recipes
          self.recipes.flatten!
        end
      end
    end
  end
end