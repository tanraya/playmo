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
# При определении рецепта он должен складываться в стек, например
# Playmo::Cookbook.defined_recipes в виде инстанса (?)
#
# То есть изначально будет заложена возможность определять рецепты как отдельно,
# так и внутри моделей (в этом случае он будет привязан к конкретной модели и не должен светиться в Playmo::Cookbook.defined_recipes)
# Лучше назвать Playmo::Cookbook.defined_recipes как Playmo::Cookbook.unbound_recipes
recipe :rspec do
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

cook!(:small_website)
cook!('small_website')
cook!(Recipe.new(:small_website) {})

###################################################################################
# Утилита playmo

# Генераторы
- Генератор для создания кукбука. Создает директорию с кукбуком.
- Генератор для создания рецепта. В качестве аргумента указывается имя кукбука.

# Использование Playmo без расширения класса Object

##################################################################
# Вариант 1
# Анонимный кукбук с анонимными рецептами в нём. Рецепты
# выполняются в порядке добавления в кукбук
one = Playmo::Recipe.new do
  # something
end

two = Playmo::Recipe.new do
  # something
end

cb = Playmo::Cookbook.new
cb.recipe(one, two)

##################################################################
# Вариант 2
# Анонимный кукбук с анонимными рецептами в нём. Рецепты
# выполняются в порядке добавления в кукбук.
# Разница с 1 вариантом в том, что метод recipe принимает блок 
cb = Playmo::Cookbook.new
cb.recipe do
  # do something
end

##################################################################
# Вариант 3
# При подмешивании модулей кукбука и рецептов к классу Object
# можно делать так. Имя у кукбука указывается обязательно, а у рецептов
# имена не указываются, т.к. эти рецепты доступны только в этом кукбуке и
# нельзя использовать их в другом кукбуке.
# Метод Object#cookbook всегда возвращает nil
cookbook :rails_app do
  recipe do
    # do something
  end

  recipe do
    # do something
  end
end

##################################################################
# Вариант 4
# Похож на вариант 3, только рецепты определены вне кукбука - это означает,
# что это общие рецепты и их можно использовать так же и в других кукбуках.
# Метод Object#recipe всегда возвращает nil
recipe :devise do
  # do something
end

recipe :cancan do
  # do something
end

cookbook :rails_app do
  recipe :devise, :cancan
end

cookbook :another_app do
  recipe :devise
end

##################################################################
# Вариант 5
# Вариант, где задано имя кукбука и имена включаемых в кукбук рецептов.
# Разница в том, что анонимные кукбуки не включаются в стек кукбуков, и
# анонимные рецепты не включаются в стек рецептов. А вот кукбуки и рецепты
# с заданными именами попадают в свои стеки, откуда их можно
# позже получить по имени.
cb = Playmo::Cookbook.new do
  recipe :one
  recipe :two
end

##################################################################
# Вариант 6
# Этот вариант аналогичен варианту 5, только теперь метод recipe
# принимает несколько имен рецептов за раз.
cb = Playmo::Cookbook.new do
  recipe :one, :two
end

##################################################################
# Вариант 7
# Этот вариант аналогичен варианту 6, только в качестве имен рецептов
# используются строки, которые конвертируются позже в символы.
cb = Playmo::Cookbook.new do
  recipe 'Rails Framework', 'Devise'
end

##################################################################
# И запускаем
Playmo::Cook.cook!(cb)

##################################################################
=begin
  tanraya-playmo gem
  Содержит примеры различных своих рецептов. Сам Playmo поставляется без рецептов.

  Запуск:
  $ playmo my_cookbooks/small_website.rb

  Генерирует приложение в текущей директории, откуда запущена программа playmo
  Разрабатывать её нужно через BDD
=end

###################################################################
# Заключения
# Нет смысла задавать имя кукбука при использовании инстансов (Playmo::Cookbook).
# Имя кукбука нужно только при использовании методов класса Object
#
# В то же время метод Playmo::Cookbook#recipe должен ументь понимать как анонимные
# рецепты, так и имена рецептов (строки и символы) определенные ранее. В этом есть смысл.
#
# Убрать имена в виде строк - пусть пока будут только символы.
#
# Поддержку версий в рецептах recipe :rails, :version => '3.1.3' добавить как-нить потом
#
