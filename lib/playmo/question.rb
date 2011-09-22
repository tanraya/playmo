module Playmo
  class Question < Thor::Shell::Basic
    attr_accessor :answers, :choice, :question_text, :caller

    def initialize(arg, &block)
      @question_text, method_name = arg, nil
      @answers ||= []
      @padding   = 0

      # Question with no answers
      if arg.respond_to? :keys
        @question_text, method_name = arg.first.first, arg.first.last
        answer(nil => method_name)
      end

      # Multiple answers
      self.instance_eval(&block) if block_given?
    end

    def set_caller(recipe)
     @caller = recipe
    end

    def answer(arg)
      @answers << Playmo::Answer.new(arg.first.first, arg.first.last, @answers.size + 1)
    end

    def has_answers?
      @answers.size > 1
    end

    def ask_question!
      say render
    end

    # Render question with answers
    def render
      result = "\n#{@question_text}"

      if has_answers?
        result += ":\n\n"
        num     = 1
        @answers.each do |answer|
          result += answer.render
          num    += 1
        end
      else
        result += "\n"
      end

      # Create choice
      @choice = Playmo::Choice.new(self, @caller)

      result
    end

    alias :to_s :render
  end
end
