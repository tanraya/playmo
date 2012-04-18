module Playmo
  COOKBOOKS = {}

  # = Cookbooks
  #
  # TODO Describe what is Cookbook here
  #
  class Cookbook #:nodoc:
    attr_accessor :name, :cookbook_recipes

    def initialize(name = nil, &block)
      raise ArgumentError, 'Block is not specified' unless block_given?

      unless name.nil?
        @name = name.to_sym
        COOKBOOKS[@name] = self
      end

      @cookbook_recipes = []
      self.instance_eval &block
    end

    def description(value = nil)
      value.nil? ? @description : @description = value
    end

    # Register cookbook recipes
    # TODO Add examples 
    def recipe(*recipes, &block)
      if recipes.size > 0
        recipes.each do |recipe|
          case recipe
          when String, Symbol
            self.cookbook_recipes << Playmo::Recipe.new(recipe, &block)
          when Playmo::Recipe
            self.cookbook_recipes << recipe
          end
        end
      else
        self.cookbook_recipes << Playmo::Recipe.new(&block)
      end
    end
  end
end