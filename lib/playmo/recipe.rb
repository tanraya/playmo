require 'rails/generators'
#require 'thor'

module Playmo
  autoload :Action
  autoload :Question
  autoload :Silent

  module Recipe
    def recipe(name, options = {}, &block)
      Recipe.new.build(name, options, &block)
    end

    class Recipe < Rails::Generators::Base
      #include Thor::Actions

      attr_accessor :name, :options, :description, :actions, :after, :application_name
      
      def build(name, options, &block)
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

      def after_install(&block)

      end

      def before_exit(&block)

      end

      def to_s
        name
      end

      # TODO: Сделать автолоадинг для зависимых рецептов
      def after(after)
        @after = after
        after_recipe = Playmo::Cookbook.instance.find_recipe(@after)

        if after_recipe.nil? && @after.present?
          require "#{File.dirname(__FILE__)}/recipes/#{@after}_recipe.rb"
        end

        puts "!#{@after} - #{after_recipe.try(:name)}"

        if after_recipe.nil?
          Playmo::Cookbook.instance.use(self)
        else
          Playmo::Cookbook.instance.insert_after(after_recipe, self)
        end
      end

      def cook!(application_name)
        self.destination_root = application_name
        self.application_name = application_name

        actions.each do |action|
          action.call
        end
      end
    end
  end
end