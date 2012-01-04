module Playmo
  autoload :Action
  autoload :Question
  autoload :Silent

  module Recipe
    def recipe(name, options = {}, &block)
      Recipe.new(name, options, &block)
    end

    class Recipe
      attr_accessor :name, :options, :description, :actions, :after

      def initialize(name, options, &block)
        raise 'Recipe name not specified!' unless name

        @name    = name
        @options = options
        @actions = []

        instance_eval &block
      end

      def description(description)
        @description = description
      end

      # Если блок с агрументами - то поддерживается ввод данных пользователем
      def question(question, &block)
        @actions << lambda { Playmo::Question.new(self, question, :type => :question, &block).to_s }
      end

      def ask(question, &block)
        @actions << lambda { Playmo::Question.new(self, question, :type => :ask, &block).to_s }
      end

      def silently(&block)
        @actions << lambda { Playmo::Silent.new(self, &block) }
      end

      def store(*args)

      end

      def retrieve(*args)

      end

      def to_s
        name
      end

      # TODO: Сделать автолоадинг для зависимых рецептов
      def after(after)
        @after = after
        recipe = Playmo::Cookbook.instance.find_recipe(@after)

        if recipe.nil?
          require "#{File.dirname(__FILE__)}/recipes/#{@after}_recipe.rb"
          Playmo::Cookbook.instance.use(self)
        else
          puts "Recipe: #{recipe.to_s}"
          Playmo::Cookbook.instance.insert_after(recipe, self)
        end
      end

      def cook!(application_name)
        actions.each { |action| action.call }
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
