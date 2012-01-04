module Playmo
  class Silent
    def initialize(recipe, &block)
      Playmo::Action.new(recipe, &block)
    end
  end
end


__END__
module Playmo
  class Silent
    attr_accessor :caller, :block

    def initialize(&block)
      @block = block
    end

    def set_caller(caller)
      @caller = caller
    end

    def execute!
      block.call
    end
  end
end
