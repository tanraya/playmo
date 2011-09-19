require 'active_support'
require "#{File.dirname(__FILE__)}/installers/base"

module Playmo
  module Generators
    # Рецепт содержит разные колбэки

    # TODO:
    # - Создать систему хуков, чтобы можно было выполнять отложенные задачи из инсталлера
    # - При запуске генератора рисовать кол-во вопросов и небольшое вступление (сделать отдельным рецептом)
    # - М.б. поддержку колбэков тут нужно делать при помощи обсервера
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a Playmo initializer and copy files to your application."

      # TODO: After install and before install events
      def install
        cookbook = Playmo::Cookbook.instance

        # Рецепты подписываются на событие обсервера до и после инсталляции
        # Здесь вызывается событие до инсталляции
        #run_callbacks :install do
          cookbook.each do |recipe|
            puts recipe
          end
        #end
        # Здесь вызывается событие после инсталляции
      end
    end
  end
end
