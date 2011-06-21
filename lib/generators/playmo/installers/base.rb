module Playmo
  module Generators
    module Installers
      class Base
        # Here we put all questions with proc's
        attr_accessor :questions_stack

      protected

        def question(arg, &block)
          if arg.respond_to? :keys
            ask_question(arg.first.first, arg.first.last)
          else
            ask_question(arg)
          end

          instance_eval(&block) if block_given?
          wait_for_user_input
        end

        def answer(arg)
          if arg.respond_to? :keys
            give_answer(arg.first.first, arg.first.last)
          else
            give_answer(arg)
          end
        end

        def notify(text)
          puts "Notify: #{text}"
        end

        def ask_question(question, method = nil)
          puts "Question: #{question}"
        end

        def give_answer(answer, method = nil)
          puts "Answer: #{answer}"
        end

        def wait_for_user_input
          puts "Your choice:"
        end
      end
    end
  end
end