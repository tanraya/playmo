module Playmo
  module Generators
    module Installers
      class JavascriptFramework < Base
        # Если вопрос без вариантов ответов - генерить (y/n), в
        # противном случае - (1, 2 or 3)

        def setup
          question "Please choose JS framework you prefer to install" do
            answer "JQuery 1.5.2 (with Jquery UI)"   => Proc.new { self.install_jquery    }
            answer "Mootools Core 1.3.1 (with More)" => Proc.new { self.install_mootools  }
            answer "Prototype"                       => Proc.new { self.install_prototype }
            answer "No one"
          end
        end

      protected

        # Есть 3 гема с этими фреймворками, но так же нужно добавить ujs для них
        # Гемы нужно добавлять в Gemfile, а так же удалять оттуда, если они существуют.
        # Лучше все записывать куда-нить, а потом пачкой генерить/удалять файлы или добавлять гемы,
        # таким образом будет возможность сгенерировать, например, красивый Gemfile

        def install_jquery
          gem "jquery-rails"
        end

        def install_mootools
          gem "jquery-mootools"
        end

        def install_prototype
          gem "jquery-prototype"
        end
      end
    end
  end
end