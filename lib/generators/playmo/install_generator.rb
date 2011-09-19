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
        # Когда происходит событие, то рецепты уведомляются о событии и запускают колбэки, соответствующие событию
        # Еще факт в том, что рецепты тоже могут производить события, а другие рецепты на них подписываться (ожидать)
        # Здесь вызывается событие до инсталляции

        # Метод fire уведомляет обсервер о произошедшем событии before_playmo_install (обсервер в свою очередь уведомляет всех подписчиков)
        # и незамедлительно выполняет переданные ему блок кода, и сразу после уведомляет о событии after_playmo_install
        fire :playmo_install do
          # cookbook.cook_recipes!
          cookbook.each do |recipe|
            # recipe.cook!
            puts recipe
          end
          # Здесь вызывается событие после инсталляции
        end
      end
    end
  end
end
