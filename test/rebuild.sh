rm -rf ./dummy
rails new dummy -d mysql
echo "gem 'playmo', :path => '../../', :branch => 'rails3.1'" >> ./dummy/Gemfile
echo "gem 'therubyracer'" >> ./dummy/Gemfile
cd dummy/
bundle
rake db:create
rails s
