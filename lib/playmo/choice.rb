module Playmo
  class Choice < Thor::Shell::Basic
    CAPTION = "\nMake your choice"
    attr_accessor :question, :choice, :accepted_values, :user_input, :caller

    def initialize(question, caller)
      @question = question
      @caller   = caller
      @padding  = 0
      @choice   = nil

      if @question.has_answers?
        @accepted_values = 1.upto(@question.answers.size).to_a.map { |value| value.to_s }
      else
        @accepted_values = %w/y n yes no/
      end
    end

    def make_choice!
      until @accepted_values.include?(@user_input) do
        @user_input = ask render
        @user_input.downcase!
      end

      if @user_input
        if @question.has_answers?
          answer = @question.answers.find { |answer| answer.num.to_s == @user_input }
          @caller.send(answer.method_name)
        else
          answer = @question.answers.first
          @caller.send(answer.method_name) if %w/y yes/.include?(@user_input)
        end
      end
    end

    def render
      if @question.has_answers?
        sentence = @accepted_values.to_sentence(
          :last_word_connector => ' or '
        )
      else
        sentence = "y/n"
      end

      CAPTION + " (#{sentence}):"
    end

    alias :to_s :render
  end
end