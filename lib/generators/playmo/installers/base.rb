require 'playmo/question'
require 'playmo/answer'
require 'playmo/choice'

module Playmo
  module Generators
    module Installers
      class Base < Rails::Generators::Base
        attr_accessor :question_instance

        def question(arg, &block)
          question, method = arg, nil

          if arg.respond_to? :keys
            question, method = nil, nil#arg.first.first, self.method(arg.first.last)
          end

          @question_instance = Playmo::Question.new(question, method)
          @question_instance.instance_eval(&block) if block_given?
          #@question_instance.choice = Proc.new {  }

          
          #@@question_stack ||= []
          #@@question_stack << @question
        end

        # Move into Playmo::Question
=begin
        def answer(arg)
          answer, method = arg, nil

          if arg.respond_to? :keys
            answer, method = arg.first.first, method(arg.first.last)
          end

          @question.answers << Playmo::Answer.new(answer, method)
        end
=end

        #def self.question_stack
        #  @@question_stack
        #end
      end
    end
  end
end