recipe :gemfile do
  description 'This will add necessary gems'
  after :rvm
  
  silently do
    gem 'rake', '~> 0.9.2'
    gem 'therubyracer', '0.9.9'
    gem 'playmo', Playmo::VERSION, :group => :development
  end
end