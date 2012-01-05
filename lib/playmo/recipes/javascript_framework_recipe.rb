recipe :javascript_framework do
  description 'Something'
  after :forms
  
  question "Please choose JS framework you prefer to use" do

    # See https://github.com/rails/jquery-rails for details
    answer "JQuery with Jquery UI" do
      gem "jquery-rails"

      gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
        <<-CONTENT.gsub(/^ {14}/, '')
          //= require jquery
          //= require jquery_ui
          //= require jquery_ujs
          //= require_tree .
        CONTENT
      end
    end

    # See https://github.com/neonlex/mootools-rails for details
    answer "Mootools Core with More" do
      gem 'mootools-rails'

      gsub_file 'app/assets/javascripts/application.js', '//= require_tree .' do
        <<-CONTENT.gsub(/^ {14}/, '')
          //= require mootools
          //= require mootools-more
          //= require mootools_ujs
          //= require_tree .
        CONTENT
      end
    end
  end
end