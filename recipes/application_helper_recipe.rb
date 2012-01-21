recipe :application_helper do
  description 'This will add helpers that used within generated layout and views'
  after :home_controller
  
  silently do
    copy_file 'playmo_helper.rb', 'app/helpers/playmo_helper.rb'

    # TODO: Add version for prototype and Jquery
    framework = retrieve :javascript_framework
    copy_file "flash_messages_#{framework}.js.coffee", "app/assets/javascripts/flash_messages.js.coffee"

    gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
      <<-CONTENT.gsub(/^ {8}/, '')
        //= require flash_messages
        //= require_tree .
      CONTENT
    end
  end
end