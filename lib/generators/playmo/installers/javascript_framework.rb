module Playmo
  module Generators
    module Installers
      class JavascriptFramework < Base
        def setup
          question "Please choose JS framework you prefer to install" do
            answer "JQuery (with Jquery UI)"                => :install_jquery
            answer "Mootools Core (with More)"              => :install_mootools
            answer "Prototype (with Scriptaculous and RJS)" => :install_prototype
          end
        end

      protected

        # See https://github.com/rails/jquery-rails for detailt
        def install_jquery
          gem "jquery-rails"
        end

        # See https://github.com/neonlex/mootools-rails for detailt
        def install_mootools
          gem 'mootools-rails'
        end

        # See https://github.com/rails/prototype-rails for details
        def install_prototype
          gem "prototype-rails"
        end
      end
    end
  end
end