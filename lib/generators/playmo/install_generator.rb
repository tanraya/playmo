require 'active_support'
require "#{File.dirname(__FILE__)}/installers/base"

module Playmo
  module Generators
    INSTALLERS = [
      :JavascriptFramework,
      :HomeController,
      :Html5Support,
#      :DefaultUser,
      #:Compass,
#      :Capistrano,
#      :Git,
      #:Rvm (Проверять, есть ли rvm на машине, устанавливает .rvmrc, создает гемсет)
    ]


    module Callbacks
      def self.extended(base)
        base.class_eval do
          include ActiveSupport::Callbacks
        end
      end

      def after_bundle_install(method, &block)
        define_callbacks :bundle_install
        set_callback(:bundle_install, :after, method, &block)
      end

      #def before_bundle_install(method, &block)
      #  set_callback(:bundle_install, :before, method, &block)
      #end
    end

    # TODO:
    # - Создать систему хуков, чтобы можно было выполнять отложенные задачи из инсталлера
    # - Поддержка инсталлеров, которые не задают вопросов
    # - При запуске генератора рисовать кол-во вопросов и небольшое вступление
    # - Убрать source_root отсюда
    class InstallGenerator < Rails::Generators::Base
      #extend Callbacks
      
      #after_bundle_install :run_delayed_generators!
      #source_root File.expand_path('../templates', __FILE__)
      #desc "Creates a Playmo initializer and copy files to your application."

  include ActiveSupport::Callbacks

  define_callbacks :validate

  #set_callback :validate, :after, :validate!

      def install
        INSTALLERS.each do |installer|
=begin
          require "#{File.dirname(__FILE__)}/installers/#{installer.to_s.underscore}"

          # Setup installer
          installer = Installers.const_get(installer).new
          installer.setup

          q = installer.question_instance

          # Ask question
          q.ask_question!

          # Ask for choice and make choice
          q.choice.make_choice!
=end
        end

        install_gems!
      end

      def install_gems!
#    run_callbacks :validate do
 #     puts 'install_gems!'
  #  end
        #run_callbacks(:bundle_install) do
        #  puts 'bundle install'
        #end
      end

  def validate!
    puts 'validate!'
  end

      def run_delayed_generators!
        puts 'Here we run all delayed generators'
      end
    end
  end
end
