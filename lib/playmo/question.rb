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

__END__
module Playmo
  class Question < Thor::Shell::Basic
    attr_accessor :answers, :choice, :question_text, :caller

    def initialize(arg, &block)
      @question_text, method_name = arg, nil
      @answers ||= []
      @padding   = 0

      # Question with no answers
      if arg.respond_to? :keys
        @question_text, method_name = arg.first.first, arg.first.last
        answer(nil => method_name)
      end

      # Multiple answers
      self.instance_eval(&block) if block_given?
    end

    def set_caller(recipe)
     @caller = recipe
    end

    def answer(arg)
      @answers << Playmo::Answer.new(arg.first.first, arg.first.last, @answers.size + 1)
    end

    def has_answers?
      @answers.size > 1
    end

    def ask_question!
      say render
    end

    # Render question with answers
    def render
      result = "\n#{@question_text}"

      if has_answers?
        result += ":\n\n"
        num     = 1
        @answers.each do |answer|
          result += answer.render
          num    += 1
        end
      else
        result += "\n"
      end

      # Create choice
      @choice = Playmo::Choice.new(self, @caller)

      result
    end

    alias :to_s :render
  end
end
