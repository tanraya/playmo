module Playmo
  RECIPES = {}

  # = Recipes
  #
  # TODO Describe what is Recipe here
  #
  class Recipe #:nodoc:
    attr_accessor :name

    def initialize(name = nil, &block)
      raise ArgumentError, 'Block is not specified' unless block_given?

      unless name.nil?
        @name = name.to_sym
        RECIPES[@name] = self
      end

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