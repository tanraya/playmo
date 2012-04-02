require 'rails/generators'

module Playmo
  autoload :Action
  autoload :Question
  autoload :Silent
  autoload :Recipe, 'playmo/recipe/recipe'
  autoload :Dsl,    'playmo/recipe/dsl'

  module Recipe
    def recipe(name, options = {}, &block)
      Dsl.new(name, options, &block)
    end
  end
end
