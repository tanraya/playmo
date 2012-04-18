module Playmo
  module Helpers
    def cookbook(name, &block)
      Cookbook.new(name, &block)
    end

    def recipe(name, &block)
      Recipe.new(name, &block)
    end

    def cook!(cookbook)
      raise ArgumentError, 'Cookbok not specified' unless cookbook
    end
  end
end