#require 'thor/actions'
require 'rails/generators'

module Playmo
  class Action < Rails::Generators::Base
    #include Thor::Actions
    #include Rails::Generators::Base
    cattr_accessor :actions

    # TODO: Сделать опцию dry-run, когда ничего не происходит, а только
    # показывается порядок запуска рецептов
    def initialize(recipe, &block)
      # Откладываем непосредственный запуск
      @@actions ||= []
      @@actions << [recipe, block]

      #recipe.instance_eval &block
      #puts "fuck" if block_given?
      #if block.arity > 0
      #  puts "We have args!"
      #  recipe.instance_eval &block
      #else
        #puts "It seems we have answers"
      #  instance_eval &block
      #end
    end

    def self.execute_all
      @@actions.each do |action|
      	recipe, block = action[0], action[1]
      	recipe.instance_eval &block
      end
    end
  end
end