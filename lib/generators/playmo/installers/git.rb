module Playmo::Generators::Installers
  class Git < Base
    def initialize
      question "Do you want to initialize git repository right now?" => :init_repository
    end

    protected

    def init_repository
      
    end
  end
end