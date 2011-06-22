module Playmo
  class Answer
    attr_accessor :answer, :proc, :num

    def initialize(answer, proc, num)
      @answer = answer
      @proc   = proc
      @num    = num
    end

    def to_s
      "#{@num}. #{@answer}\n"
    end
  end
end