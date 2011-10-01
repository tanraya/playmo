module Playmo
  module Generators
    # Рецепт содержит разные колбэки

    # TODO:
    # - Создать систему хуков, чтобы можно было выполнять отложенные задачи из инсталлера
    # - При запуске генератора рисовать кол-во вопросов и небольшое вступление (сделать отдельным рецептом)
    # - М.б. поддержку колбэков тут нужно делать при помощи обсервера
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "Creates a Playmo initializer and copy files to your application."

      def install
        # Рецепты подписываются на событие обсервера до и после инсталляции
        # Когда происходит событие, то рецепты уведомляются о событии и запускают колбэки, соответствующие событию
        # Еще факт в том, что рецепты тоже могут производить события, а другие рецепты на них подписываться (ожидать)
        # Здесь вызывается событие до инсталляции

        # Метод fire уведомляет обсервер о произошедшем событии before_playmo_install (обсервер в свою очередь уведомляет всех подписчиков)
        # и незамедлительно выполняет переданные ему блок кода, и сразу после уведомляет о событии after_playmo_install

        # Вот схема: http://www.oodesign.com/observer-pattern.html
        # Мне нужно сделать модуль EventSubscriber, который буду подмешивать в нужные классы, чтобы классы смогли подписываться на события.
        # Тогда рецепты будут одновременно оbservable и subscribers?
        #Playmo::Cookbook.instance.cook_recipes!

                  gem "devise"
                  if yes? "Bundle?"
          run "bundle install --gemfile=/home/tanraya/sandbox/playmo/test/dummy/Gemfile"
                    end
      end
    end
  end
end
