#require 'thor/actions'


module Playmo
  class Action
    cattr_accessor :actions

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
        
        recipe.class.class_eval do
          source_root "#{Playmo::ROOT}/recipes/templates/#{recipe.name}_recipe"
        end

        begin
      	  recipe.instance_eval &block
        rescue Exception => e
          puts "Playmo ERROR!"
          puts recipe.to_s
          puts e
          exit!
        end
      end
    end
  end
end