recipe :rspec do
  description 'Something'
  after :thinking_sphinx
  
  ask "Would you like to use Rspec in this project?" do
    gem 'rspec-rails'

    after_install do
      generate "rspec:install"
      remove_dir "test"
      
      inject_into_file "config/application.rb", :after => "class Application < Rails::Application\n" do
        <<-CONTENT.gsub(/^ {10}/, '')
          config.generators do |g|
            g.test_framework :rspec
          end
        CONTENT
      end
    end
    
    # TODO: copy helpers etc
    # TODO: factory_girl etc
  end
end