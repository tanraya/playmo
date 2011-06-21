module Playmo::Generators::Installers
  class Capistrano < Base
    def initialize
      question "Do you want to use Capistrano and capify this project?" => :add_capistrano
    end

  protected

    def add_capistrano
      
    end
  end
end