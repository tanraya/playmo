require 'rails/generators'

module Playmo
  autoload :Action
  autoload :Question
  autoload :Silent

  module Recipe
    def recipe(name, options = {}, &block)
      Recipe.new(name, options, &block)
    end

    class Recipe < Rails::Generators::Base
      attr_accessor :name, :options, :description, :actions, :after, :application_name
      
      def initialize(name, options, &block)
        raise 'Recipe name not specified!' unless name

        @name    = name
        @options = options
        @actions = []

        #self.class.class_eval do
        #  puts File.expand_path("../recipes/templates/#{name}_recipe", __FILE__)
        #  source_root File.expand_path("../recipes/templates/#{name}_recipe", __FILE__)
        #end

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
          #puts "Recipe: #{recipe.to_s}"
          Playmo::Cookbook.instance.insert_after(recipe, self)
        end
      end

      def cook!(application_name)
        self.destination_root = application_name
        self.application_name = application_name

        recipe_name = name.to_s
        raise self.class.inspect
        self.class.class_eval do
          source_root File.expand_path("../recipes/templates/#{recipe_name}_recipe", __FILE__)
        end

        actions.each { |action| action.call }
      end
    end
  end
end