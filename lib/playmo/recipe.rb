require 'rails/generators'

module Playmo
  # Base class for all recipes
  class Recipe < Rails::Generators::Base
    #attr_accessor :question_instance, :silents

=begin
    def question(arg, &block)
      @question_instance = Playmo::Question.new(arg, &block)
    end

    def silently(&block)
      @silents ||= []
      @silents << Playmo::Silent.new(self, &block)
    end
=end
    def question(arg, &block)

    end

    def silently(&block)
      
    end
  end
end
