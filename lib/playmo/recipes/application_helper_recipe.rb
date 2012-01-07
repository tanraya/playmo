recipe :application_helper do
  description 'Helpers that used in generated views and layout'
  after :home_controller
  
  silently do
    remove_file 'app/helpers/application_helper.rb'
    copy_file   'application_helper.rb', 'app/helpers/application_helper.rb'

    # TODO: Add version for prototype and Jquery
    # TODO: Translate flash_messages.js to CoffeeScript
    copy_file   'flash_messages.js', 'app/assets/javascripts/flash_messages.js'

    gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
      <<-CONTENT.gsub(/^ {8}/, '')
        //= require flash_messages
        //= require_tree .
      CONTENT
    end

    gsub_file 'config/locales/en.yml', 'en:' do
      <<-CONTENT.gsub(/^ {8}/, '')
        en:
          helpers:
            application:
              link_to_delete:
                link_text: Delete?
                confirmation: Are you sure?
     CONTENT
    end
  end
end