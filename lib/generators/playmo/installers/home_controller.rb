module Playmo::Generators::Installers
  class HomeController
    def initialize
      question "Do you want to create HomeController in this project?" => :create_home_controller
    end

  protected

    def create_home_controller

    end
  end
end