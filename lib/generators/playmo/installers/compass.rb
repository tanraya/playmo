module Playmo
  module Generators
    module Installers
      class Compass < Base
        def setup
          question "Do you want to use Compass in this app?" => :add_compass
        end

      protected

        def add_compass
          gem 'compass'
        end
      end
    end
  end
end