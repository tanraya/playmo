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
# Этот метод должен иснтанцировать все рецепты кукбука и запускать их.
#
#
#
cook!(:small_website)
cook!('small_website')
cook!(Recipe.new(:small_website) {})

###################################################################################
# Утилита playmo

# Генераторы
- Генератор для создания кукбука. Создает директорию с кукбуком.
- Генератор для создания рецепта. В качестве аргумента указывается имя кукбука.

# Использование Playmo без расширения класса Object

# Вариант 1
one = Playmo::Recipe.new(:one) do
  # something
end

two = Playmo::Recipe.new(:two) do
  # something
end

cookbook = Playmo::Cookbook.new(:rails_app)
cookbook.recipe(one, two)

# Вариант 2

cookbook = Playmo::Cookbook.new :rails_app do
  recipe Playmo::Recipe.new(:one) do
    # do something
  end

  recipe Playmo::Recipe.new(:two) do
    # do something
  end
end

# Вариант 3

cookbook = Playmo::Cookbook.new :rails_app do
  recipe :one do
    # do something
  end

  recipe 'Another recipe' do
    # do something
  end
end

# Вариант 4

cookbook = Playmo::Cookbook.new(:rails_app)
cookbook.recipe :one do
  # do something
end

# Вариант 5

cookbook = Playmo::Cookbook.new :rails_app do
  recipe :one
  recipe :two
end

# Вариант 6

cookbook = Playmo::Cookbook.new :rails_app do
  recipe :one, :two
end

# Вариант 7

cookbook = Playmo::Cookbook.new :rails_app do
  recipe 'Rails Framework', 'Devise'
end

# И запускаем
Playmo::Cook.cook!(cookbook)

=begin

  tanraya-playmo gem
  Содержит примеры различных своих рецептов. Сам Playmo поставляется без рецептов.

  Запуск:
  $ playmo my_cookbooks/small_website.rb

  Генерирует приложение в текущей директории, откуда запущена программа playmo
  Разрабатывать её нужно через BDD
=end
