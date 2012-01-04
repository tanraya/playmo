module Playmo
  class Silent
    def initialize(recipe, &block)
      Playmo::Action.new(recipe, &block)
    end
  end
end