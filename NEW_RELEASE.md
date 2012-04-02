###################################################################################
# Playmo
# Это утилита для сборки приложений для ruby на основе рецептов и кукбуков.
###################################################################################
# Recipes

# recipes/rails.rb
recipe :rails do
  description "Rails framework"
  version '3.1.3'
  
  gem 'rails', '3.1.3'

  if application_name = ask "Enter new Rails application name: "
    run "rails new #{application_name} -JT --skip-bundle"
  end
end

# recipes/devise.rb
recipe :devise do
  gem 'devise'

  say 'Devise installed!'
end

# recipes/rspec.rb
recipe :rspec
  gem 'rspec-rails'
end

###################################################################################
# Cookbooks

# rails_website.rb
cookbook :rails_website do
  templates 'path/to/templates' # ???
  recipes 'path/to/rails_recipes'
  recipes 'path/to/common_recipes'

  recipe :rails
  recipe :devise
  recipe :rspec
end

# sinatra_website.rb
cookbook :sinatra_website do
  templates "#{cookbook_title}/path/to/templates"
  recipes 'path/to/recipes'

  recipe :sinatra
  recipe :rspec
end

# small_website.rb
cookbook :small_website do
  templates 'path/to/templates'
  recipes 'path/to/recipes'

  recipe :rspec,
         :html5layout

  recipe :rails, :version => '3.1.3'
end

# Запуск кукбука вручную
cook!(:small_website)
cook!('small_website')
cook!(Recipe.new(:small_website) {})

###################################################################################
# Утилита playmo

=begin

  tanraya-playmo gem
  Содержит примеры различных своих рецептов. Сам Playmo поставляется без рецептов.

  Запуск:
  $ playmo my_cookbooks/small_website.rb

  Генерирует приложение в текущей директории, откуда запущена программа playmo
  Разрабатывать её нужно через BDD
=end
