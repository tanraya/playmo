recipe :gemfile do
  description 'Something'
  after :setup_database
  
  silently do
    gem 'rake', '~> 0.9.2'
    gem 'therubyracer'
    gem 'playmo', :group => :development
  end
end

__END__

module Playmo
  module Recipes
    class GemfileRecipe < Playmo::Recipe
      def setup
        silently do
          gem 'rake', '~> 0.9.2'
        end
      end
    end
  end
end

# Write down this recipe to our Cookbook if it's available
require File.dirname(__FILE__) + '/setup_database_recipe'
Playmo::Cookbook.instance.insert_after(Playmo::Recipes::GitRecipe, Playmo::Recipes::GemfileRecipe) if defined?(Playmo::Cookbook)
