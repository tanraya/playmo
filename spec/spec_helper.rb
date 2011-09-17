# encoding: utf-8
require 'rubygems'
require 'bundler'
Bundler.setup

require 'rails/all'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/playmo'))

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories in alphabetic order.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
 # nothing yet ...
end