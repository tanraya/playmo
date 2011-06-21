rm -rf ./dummy
rails new dummy
echo "gem 'playmo', :path => '../playmo', :branch => 'rails3.1'" >> ./dummy/Gemfile
echo "gem 'therubyracer'" >> ./dummy/Gemfile
cd dummy/
bundle
rails s
