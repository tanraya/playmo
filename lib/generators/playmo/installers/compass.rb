module Playmo::Generators::Installers
  class Compass < Base
    def initialize
      question "Do you want to use Compass in this project?" => :add_compass
    end

  protected

    def add_compass

    end
  end
end