require 'rails/generators'

module Playmo
  # Base class for all recipes
  class Recipe < Rails::Generators::Base
    source_root File.expand_path('../generators/playmo/recipes/templates', __FILE__)
    attr_accessor :question_instance, :silents

    def question(arg, &block)
      @question_instance = Playmo::Question.new(arg, &block)
    end

    def silently(&block)
      @silents ||= []
      @silents << Playmo::Silent.new(self, &block)
    end
  end
end
