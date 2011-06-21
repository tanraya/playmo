module Playmo::Generators::Installers
  class JavascriptFramework
    def initialize
      title "Please choose JS framework you prefer to install"

      answer "JQuery 1.5.2 (with Jquery UI)"   => :install_jquery
      answer "Mootools Core 1.3.1 (with More)" => :install_mootools
      answer "Prototype"                       => :install_prototype
    end

  protected
    # Есть 3 гема с этими фреймворками, но так же нужно добавить ujs для них
    # Гемы нужно добавлять в Gemfile, а так же удалять оттуда, если они существуют.
    # Лучше все записывать куда-нить, а потом пачкой генерить/удалять файлы или добавлять гемы,
    # таким образом будет возможность сгенерировать, например, красивый Gemfile

    def install_jquery

    end

    def install_mootools

    end

    def install_prototype

    end
  end
end