module Playmo
  class Question
    attr_accessor :answers, :choice, :question, :deferred_method

    def initialize(question, proc)
      @answers ||= []
      @question  = question
      @proc      = proc
    end

    def answer(arg)
      answer, proc = arg, nil

      if arg.respond_to? :keys
        answer, proc = arg.first.first, arg.first.last
      end

      @answers << Playmo::Answer.new(answer, proc, @answers.size + 1)
    end

    def request_choice(choice)
      @choice = Playmo::Choice.new(choice, self)
    end

    # Render question with answers
    def to_s
      result = @question + ":\n\n"

      num = 1
      @answers.each do |answer|
        result += answer.to_s
        num    += 1
      end

      result
    end
  end
end