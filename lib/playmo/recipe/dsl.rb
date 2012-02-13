module Playmo
  module Recipe
    class Dsl < Playmo::Recipe::Recipe
      attr_accessor :description, :name, :options, :after

      def initialize(name, options, &block)
        super()

        raise 'Recipe name not specified!' unless name

        @name    = name
        @options = options

        instance_eval &block
      end

      def description(description = nil)
        @description = description if description.present?
        @description
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
          #$:.each {|path| puts "!#{path}!"}
          #raise "FUCK!!!"

          #require "#{Playmo::ROOT}/recipes/#{@after}_recipe.rb"
          begin
            require "#{@after}_recipe.rb"
          rescue LoadError => e
            puts "Cannot load recipe '#{@after}_recipe.rb'!"
            puts "LOAD PATHS:\n#{$:.join("\n")}"
            exit!
          end
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