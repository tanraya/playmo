require 'rails/generators'

module Playmo
  # Base class for all recipes
  class Recipe < Rails::Generators::Base
    attr_accessor :question_instance, :silents

    def self.question(arg, &block)
      @question_instance = Playmo::Question.new(arg, self, &block)
    end

    def self.silently(&block)
      @silents ||= []
      @silents << Playmo::Silent.new(self, &block)
    end
  end
end