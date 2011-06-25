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
            question, method = arg.first.first, arg.first.last
          end

          @question_instance = Playmo::Question.new(question, method)
          @question_instance.instance_eval(&block) if block_given?
        end
      end
    end
  end
end