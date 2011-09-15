module Playmo
  module Generators
    module Installers
      class Html5Support < Base
        source_root File.expand_path('../templates/html5_support', __FILE__)

        def setup
          question "Would you like to use html5 in your app?" => :use_html5
        end

      protected

        def use_html5
          install_layout
        end

        def install_layout
          remove_file "app/views/layouts/application.html.erb"
          generate :layout
        end
      end
    end
  end
end