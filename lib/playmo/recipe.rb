require 'rails/generators'

module Playmo
  # Base class for all recipes
  class Recipe < Rails::Generators::Base
    attr_accessor :question_instance, :silents, :application_name

    # Приготовление рецепта
    def cook!(application_name)
      self.destination_root = application_name
      self.application_name = application_name

      name = self.class.to_s.underscore.split('/').last

      self.class.class_eval do   
        source_root File.expand_path("../recipes/templates/#{name}", __FILE__)
      end

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

    def store(*args)
      Options.instance.set(*args)
    end

    def retrieve(*args)
      Options.instance.get(*args)
    end
  end
end
