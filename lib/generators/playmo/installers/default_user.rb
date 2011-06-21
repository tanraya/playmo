module Playmo::Generators::Installers
  class DefaultUser < Base
    def initialize
      question "Do you want to create default user?" => :create_default_user
      # Если согласен, то предлагать установить Devise и CanCan
    end

  protected

    def create_default_user

    end
  end
end