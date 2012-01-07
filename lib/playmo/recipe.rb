require 'rails/generators'

module Playmo
  autoload :Action
  autoload :Question
  autoload :Silent

  module Recipe
    def recipe(name, options = {}, &block)
      Dsl.new(name, options, &block)
    end

    # Переименовать этот класс в DSL, и сделать отдельный класс Recipe,
    # который будет предком DSL и от которого можно наследоваться для создания complex recipes
    # У класса DSL будут еще свои методы типма build (?)
    class Recipe < Rails::Generators::Base
      attr_accessor :actions, :application_name
      
      def initialize
        super
        
        @actions = []
      end

      def store(*args)

      end

      def retrieve(*args)

      end

      # TODO: Move it into module
      def after_install(&block)
        #
        Event.events.listen(:after_install) { block.call }
      end

      def before_exit(&block)
        Event.events.listen(:before_exit) { block.call }
      end

      def generate(*args)
        after_install { super(*args) }
      end

      def cook!(application_name)
        self.destination_root = application_name
        self.application_name = application_name

        #puts "cook: #{@actions.size}"
        actions.each do |action|
          action.call
        end
      end

      def to_s
        name
      end
    end


    class Dsl < Playmo::Recipe::Recipe
      attr_accessor :description, :name, :options, :after

      def initialize(name, options, &block)
        super()

        raise 'Recipe name not specified!' unless name

        @name    = name
        @options = options
        #@actions = []

        instance_eval &block
      end

      def description(description)
        @description = description
      end

      # Если блок с агрументами - то поддерживается ввод данных пользователем
      def question(question, &block)
        actions << lambda { Playmo::Question.new(self, question, :type => :question, &block).to_s }
      end

      def ask(question, &block)
        actions << lambda { Playmo::Question.new(self, question, :type => :ask, &block).to_s }
      end

      def silently(&block)
        actions << lambda { Playmo::Silent.new(self, &block) }
      end

      # TODO: Сделать автолоадинг для зависимых рецептов
      def after(after)
        @after = after
        after_recipe = Playmo::Cookbook.instance.find_recipe(@after)

        if after_recipe.nil? && @after.present?
          require "#{File.dirname(__FILE__)}/recipes/#{@after}_recipe.rb"
        end

        if after_recipe.nil?
          Playmo::Cookbook.instance.use(self)
        else
          Playmo::Cookbook.instance.insert_after(after_recipe, self)
        end
      end
    end
  end
end