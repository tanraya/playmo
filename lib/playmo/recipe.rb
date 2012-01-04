module Playmo
  autoload :Action
  autoload :Question
  autoload :Silent

  module Recipe
    def recipe(name, options = {}, &block)
      Recipe.new(name, options, &block)
    end

    class Recipe
      attr_accessor :name, :options, :description, :after

      def initialize(name, options, &block)
        raise 'Recipe name not specified!' unless name

        @name    = name
        @options = options

        instance_eval &block
      end

      def description(description)
        @description = description
      end

      # Если блок с агрументами - то поддерживается ввод данных пользователем
      def question(question, &block)
        Playmo::Question.new(self, question, &block).to_s
      end

      def silently(&block)
        Playmo::Silent.new(self, &block)
      end

      def store(*args)

      end

      def retrieve(*args)

      end

      # TODO: Сделать автолоадинг для зависимых рецептов
      def after(after)
        @after = after

        unless @after.nil?
          require "#{File.dirname(__FILE__)}/recipes/#{@after}_recipe.rb"
          recipe = Playmo::Cookbook.instance.find_recipe(@after)
          Playmo::Cookbook.instance.insert_after(recipe, self) unless recipe.nil?
        else
          Playmo::Cookbook.instance.use(self)
        end
      end
    end
  end
end





__END__
require 'rails/generators'

module Playmo
  # Base class for all recipes
  class Recipe < Rails::Generators::Base
    attr_accessor :question_instance, :silents, :application_name

    # Приготовление рецепта
    def cook!(application_name)
      self.destination_root = application_name
      self.application_name = application_name
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
