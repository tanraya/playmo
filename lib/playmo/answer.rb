module Playmo
  class Answer
    attr_accessor :answer, :options, :num, :block, :color

    def initialize(answer, options, num, &block)
      @answer  = answer
      @options = options
      @num     = num
      @block   = block
      @color   = Thor::Shell::Color.new
    end

    def default?
      options.try(:[], :default) == true
    end

    def render
      if @answer
        result = color.set_color("#{@num}. #{@answer}", :white, true)
        result << " (default)" if default?
        result
      end
    end

    alias :to_s :render
  end
end