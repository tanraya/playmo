module Playmo
  class Choice
    CAPTION = "Your choice"
    attr_accessor :question, :shell, :color, :user_input

    def initialize(question)
      @question = question
      @shell    = Thor::Shell::Basic.new
      @color    = Thor::Shell::Color.new
    end

    def accepted_values
      if question.has_answers?
        1.upto(question.answers.size).to_a.map { |value| value.to_s }
      else
        %w/y n yes no/
      end
    end

    def get_answer
      shell.padding = 1

      until accepted_values.include?(@user_input) do
        @user_input = shell.ask(render)
        @user_input.downcase!
      end

      if @user_input
        if question.has_answers?
          answer = question.answers.find { |answer| answer.num.to_s == @user_input }
        else
          answer = question.answers.first
        end

        answer
      end
    end

    def render
      if question.has_answers?
        sentence = accepted_values.to_sentence(
          :last_word_connector => ' or '
        )
      else
        sentence = "y/n"
      end

      color.set_color("#{CAPTION} (#{sentence}):", :white, true)
    end

    alias :to_s :render
  end
end
