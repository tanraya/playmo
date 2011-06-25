module Playmo
  class Choice
    CAPTION = "\nMake your choice"
    attr_accessor :question

    def initialize(question)
      @question = question
    end

    def to_s
      if @question.answers.any?
        sentence = 1.upto(@question.answers.size).to_a.to_sentence( :last_word_connector => ' or ' )
      else
        sentence = "y/n"
      end

      CAPTION + " (#{sentence}):"
    end
  end
end