recipe :rspec do
  description 'This will add Rspec testing library into your app instead of Test::Unit'
  after :thinking_sphinx
  
  ask "Would you like to use Rspec in this project?" do
    gem 'rspec-rails', :group => :development
    generate "rspec:install"
    remove_dir "test"
    
    inject_into_file "config/application.rb", :after => "class Application < Rails::Application\n" do
      <<-CONTENT.gsub(/^ {8}/, '')
        config.generators do |g|
          g.test_framework :rspec
        end
      CONTENT
    end

    # TODO: copy helpers etc
    # TODO: factory_girl etc
  end
end