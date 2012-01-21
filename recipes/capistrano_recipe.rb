recipe :capistrano do
  description 'This will add remote multi-server automation tool'
  after :rspec
  
  ask "Would you like to deploy project with Capistrano?" do
    gem 'capistrano'

    install do
      capify!
      remove_file "config/deploy.rb"
      template    "deploy.rb", "config/deploy.rb"
    end
  end
end