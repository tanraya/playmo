module Playmo
  class Choice
    CAPTION = "\nMake your choice:"
    attr_accessor :choice, :question

    def initialize(choice, question)
      @choice   = choice
      @question = question
    end

    def to_s
      sentence = 1.upto(@question.answers.size).to_sentence( :connector => ' or ')
      CAPTION + " (#{sentence})"
    end
  end
end