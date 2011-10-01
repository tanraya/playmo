# 
require 'rubygems'
require 'thor'

class Recipe
  include Thor::Actions
  # https://gist.github.com/460844
  def setup
    if yes?("Use MIT license?")
puts 'ok'
    end
    #gem 'unicorn'
    #run 'bundle install'
  end
end

Recipe.new.setup
