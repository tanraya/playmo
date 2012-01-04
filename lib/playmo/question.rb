require 'thor/shell/basic'
require 'thor/shell/color'

module Playmo
  autoload :Answer
  autoload :Choice

  class Question
    attr_accessor :question, :answers, :recipe, :action, :shell, :color

    def initialize(recipe, question, options, &block)
      @question = question
      @answers  = []
      @recipe   = recipe
      @options  = options
      @shell    = Thor::Shell::Basic.new
      @color    = Thor::Shell::Color.new

      if @options[:type] == :question
        instance_eval &block
      elsif @options[:type] == :ask
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
      
      if has_answers?
        shell.say("\n")

        answers.each do |answer|
          shell.say("#{answer}")
        end
      end

      shell.say("\n")

      choice = Playmo::Choice.new(self)
      answer_action = choice.get_answer.action
      Playmo::Action.new(recipe, &answer_action)

      #if has_answers?
      #  Playmo::Action.new(recipe, &answer_action)
      #else
      #  Playmo::Action.new(recipe, &action)
      #end
    end

    alias :to_s :render
  end
end