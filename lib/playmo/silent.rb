module Playmo
  class Silent
    attr_accessor :caller

    def initialize(caller, &block)
      @caller = caller
    end
  end
end