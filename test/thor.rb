# 
require 'thor'

class Recipe
  include Thor::Actions
  # https://gist.github.com/460844
  def setup
    gem 'unicorn'
    run 'bundle install'
  end
end

Recipe.new.setup
