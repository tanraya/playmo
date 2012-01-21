recipe :javascript_framework do
  description 'This will add javascript framework into your app'
  after :forms
  
  question "Please choose JS framework you prefer to use" do

    # See https://github.com/rails/jquery-rails for details
    answer "JQuery with Jquery UI", :default => true do
      gem "jquery-rails"

      gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
        <<-CONTENT.gsub(/^ {10}/, '')
          //= require jquery
          //= require jquery-ui
          //= require jquery_ujs
          //= require_tree .
        CONTENT
      end

      store :javascript_framework, :jquery
    end

    # See https://github.com/neonlex/mootools-rails for details
    answer "Mootools Core with More" do
      gem 'mootools-rails'

      gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
        <<-CONTENT.gsub(/^ {10}/, '')
          //= require mootools
          //= require mootools-more
          //= require mootools_ujs
          //= require_tree .
        CONTENT
      end

      store :javascript_framework, :mootools
    end
  end
end