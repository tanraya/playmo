require 'rails/generators'

module Playmo
  # Base class for all recipes
  class Recipe < Rails::Generators::Base
    attr_accessor :question_instance, :silents

    # Приготовление рецепта
    def cook!
      setup

      unless question_instance.nil?
        question_instance.set_caller(self)

        # Ask question
        question_instance.ask_question!

        # Ask for choice and make choice
        question_instance.choice.make_choice!
      end

      # Execute all silents
      unless silents.nil?
        silents.each do |silent|
          silent.set_caller(self)
          silent.execute!
        end
      end
    end

    def question(arg, &block)
      @question_instance = Playmo::Question.new(arg, &block)
    end

    def silently(&block)
      @silents ||= []
      @silents << Playmo::Silent.new(&block)
    end
  end
end
