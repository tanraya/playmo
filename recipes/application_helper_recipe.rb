recipe :application_helper do
  description 'This will add helpers that used within generated layout and views'
  after :home_controller
  
  silently do
    copy_file 'playmo_helper.rb', 'app/helpers/playmo_helper.rb'

    # TODO: Add version for prototype and Jquery
    copy_file 'flash_messages.js.coffee', 'app/assets/javascripts/flash_messages.js.coffee'

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