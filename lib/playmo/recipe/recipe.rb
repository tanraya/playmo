module Playmo
  module Recipe
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
        Options.instance.set(*args)
      end

      def retrieve(*args)
        Options.instance.get(*args)
      end

      # TODO: Move it into module
      def after_install(&block)
        Event.events.listen(:after_install) do
          # TODO: DRY this
          recipe_name = name

          self.class.class_eval do
            source_root File.expand_path("../../recipes/templates/#{recipe_name}_recipe", __FILE__)
          end
        
          self.instance_eval &block
        end
      end

      def before_exit(&block)
        Event.events.listen(:before_exit) do
          # TODO: DRY this
          recipe_name = name

          self.class.class_eval do
            source_root File.expand_path("../../recipes/templates/#{recipe_name}_recipe", __FILE__)
          end
          
          self.instance_eval &block
        end
      end

      def generate(*args)
        after_install { super(*args) }
      end

      def cook!(application_name)
        self.destination_root = application_name
        self.application_name = application_name

        actions.each do |action|
          action.call
        end
      end

      def to_s
        name
      end
    end
  end
end