module Playmo
  class Answer < Thor::Shell::Basic
    attr_accessor :answer_text, :method_name, :num

    def initialize(answer_text, method_name, num)
      @answer_text  = answer_text
      @method_name  = method_name
      @num          = num
      @padding      = 0
    end

    def render
      "#{@num}. #{@answer_text}\n" if @answer_text
    end

    alias :to_s :render
  end
end