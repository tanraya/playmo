require 'thor/shell/basic'
require 'thor/shell/color'

module Playmo
  autoload :Answer
  autoload :Choice

  class Question
    attr_accessor :question, :answers, :recipe, :block, :shell, :color, :options

    def initialize(recipe, question, options, &block)
      @question = question
      @answers  = []
      @recipe   = recipe
      @options  = options
      @block    = block
      @shell    = Thor::Shell::Basic.new
      @color    = Thor::Shell::Color.new

      if @options[:type] == :question
        instance_eval &block
      elsif @options[:type] == :ask && block.arity == 0
        answer(nil, nil, &block)
      elsif @options[:type] == :ask && block.arity > 0
        answer(nil, nil, &block)
      end
 
      # Do stuff with block
=begin
      if block.arity > 0
        # We have block with args
        #answer(nil, nil, &block)
        #@action = block
      else
        #instance_eval &block
        raise block.methods.inspect
      end

      # If block without answers was passed
      unless has_answers?
        answer(nil, nil, &block)
      end
=end
    end

    def has_answers?
      @answers.size > 1
    end

    def answer(answer, options = {}, &block)
      @answers << Playmo::Answer.new(answer, options, @answers.size + 1, &block)
    end

    def render
      shell.padding = 1
      shell.say("\n")
      shell.say(color.set_color(question, :green, true))
      shell.say(color.set_color(recipe.description, :white, false))
      
      if has_answers?
        shell.say("\n")

        answers.each do |answer|
          shell.say("#{answer}")
        end
      end

      shell.say("\n")

      if options[:type] == :ask && block.arity > 0
        response = shell.ask('Enter value:')

        if block
          answer_action = block
          x = Proc.new { answer_action.call(response) }
          Playmo::Action.new(recipe, &x)
        end
      else
        choice = Playmo::Choice.new(self)
        answer = choice.get_answer

        if answer
          answer_action = answer.block
          Playmo::Action.new(recipe, &answer_action)
        end
      end
    end

    alias :to_s :render
  end
end