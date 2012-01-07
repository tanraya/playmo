recipe :gemfile do
  description 'This will add necessary gems'
  after :setup_database
  
  silently do
    gem 'rake', '~> 0.9.2'
    gem 'therubyracer'
    gem 'playmo', :group => :development
  end
end