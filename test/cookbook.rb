# Fucking simple visual test - need rspec to use! =)
require File.dirname(__FILE__) + '/../lib/playmo/cookbook'

class FirstRecipe; end
class SecondRecipe; end
class ThirdRecipe; end

cookbook = Playmo::Cookbook.new
cookbook.use(FirstRecipe)
cookbook.insert_before(FirstRecipe, ThirdRecipe)
cookbook.insert_after(ThirdRecipe, SecondRecipe)

cookbook.each do |recipe|
  puts recipe.to_s
end