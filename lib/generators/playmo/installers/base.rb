require 'playmo/question'
require 'playmo/answer'
require 'playmo/choice'

module Playmo
  module Generators
    module Installers
      class Base < Rails::Generators::Base
        attr_accessor :question_instance, :delayed_procs

        def question(arg, &block)
          @question_instance = Playmo::Question.new(arg, self, &block)
        end
      end
    end
  end
end