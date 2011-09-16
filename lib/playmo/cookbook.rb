module Playmo
  # This class contains all registered recipes.
  # You can register own recipe in this class
  class Cookbook
    include Enumerable
    attr_accessor :recipes

    def initialize
      @recipes = []
    end

    def each
      recipes.each { |x| yield x }
    end

    def size
      recipes.size
    end

    def last
      recipes.last
    end

    def [](i)
      recipes[i]
    end

    def delete(target)
      recipes.delete target
    end
    
    # Adds the new recipe before the specified existing recipe in the Cookbook stack.
    def insert(existing_recipe, new_recipe)
      index = assert_index(existing_recipe, :before)
      recipes.insert(index, new_recipe)
    end

    alias_method :insert_before, :insert

    # Adds the new recipe after the specified existing recipe in the Cookbook stack.
    def insert_after(existing_recipe, new_recipe)
      index = assert_index(existing_recipe, :after)
      insert(index + 1, new_recipe)
    end

    # Adds the new recipe at the bottom of the Cookbook stack.
    def use(new_recipe)
      recipes.push(new_recipe)
    end
    
  protected

    def assert_index(index, where)
      i = index.is_a?(Integer) ? index : recipes.index(index)
      raise "No such recipe to insert #{where}: #{index.inspect}" unless i
      i
    end
  end
end