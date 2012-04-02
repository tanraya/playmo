recipe :unicorn do
  description 'This will add Unicorn - Rack HTTP server for fast clients and Unix'
  after :application_helper
  
  ask "Would you like to use Unicorn as web server in production?" do
    gem "unicorn", :group => :production
    template "unicorn.rb", "config/unicorn.rb"
  end
end