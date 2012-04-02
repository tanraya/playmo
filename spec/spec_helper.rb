# encoding: utf-8
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'playmo'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories in alphabetic order.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
 # nothing yet ...
end