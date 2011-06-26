module Playmo
  module Generators
    module Installers
      class HomeController < Base
        def setup
          question "Do you want to create HomeController in this project?" => :create_home_controller
        end

      protected

        def create_home_controller
          gem 'unicorn'
        end
      end
    end
  end
end