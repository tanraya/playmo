# Intro

__Playmo - cook your app fast!__

Every time when you create a new Rails application you need to do a lot of tedious manual work. Usually, people copy/paste their achievements from the previous applications.

Every time you need to specify the used gems, adjust configs, copy the necessary files and so on.

Playmo can get rid of this routine once and for all. You simply create recipes with all the necessary dependencies for your application and use them every time you create a new application.

## How it works

You need just install playmo gem to your system:

    $ gem install playmo

And then you can generate your brand new application with latest Rails. Just type in the console:

    $ playmo

You should see a list of questions that you have to answer. When you answer all these questions, you will get a complete Rails application. Then you can run your app:

    $ cd ./yourappname
    $ rails s

### What it does

Playmo contains the following built-in recipes (in order of execution):

* __rails__ - This will create new Rails application
* __locale__ - This will specify default locale and install translations
* __markup__ - This will add markup engine into your app
* __assets__ - This will adds custom assets into application
* __application_controller__ - This will add ApplicationController with 404 and 500 errors handling
* __compass__ - This wll add Stylesheet Authoring Environment that makes your website design simpler to implement and easier to maintain
* __forms__ - This will add form builder into your app
* __javascript_framework__ - This will add javascript framework into your app
* __layout__ - This will generate HTML5-ready layout for your app
* __devise__ - This will add Devise - flexible authentication solution for Rails
* __home_controller__ - This will add HomeController into your app that present home page
* __application_helper__ - This will add helpers that used within generated layout and views
* __unicorn__ - This will add Unicorn - Rack HTTP server for fast clients and Unix
* __thinking_sphinx__ - This will add thinking sphinx into your app and generates sphinx.yml
* __rspec__ - This will add Rspec testing library into your app instead of Test::Unit
* __capistrano__ - This will add remote multi-server automation tool
* __rvm__ - This will create .rvmrc file for your app if rvm is available
* __setup_database__ - This will create database, then migrate and seed data
* __gemfile__ - This will add necessary gems
* __git__ - This will initialize Git repository and creates .gitignore

## How recipe looks like?

Here is an example of the built-in Playmo recipe called 'forms':

    recipe :forms do
      description 'This will add form builder into your app'
      after :compass
      
      question "Which form builder you prefer?" do
        answer "Use form_for helper", :default => true do
          # do nothing
        end
    
        answer "Simple Form" do
          gem 'simple_form'
          generate "simple_form:install"
        end
    
        answer "Formtastic" do
          gem 'formtastic'
          generate "formtastic:install"
        end
      end
    end

This recipe asks you questions, but there are other recipes, such as 'silent', who ask no questions, and just doing some work, or 'ask', which asks for input from the user.

Example of 'silent' recipe:

    recipe :rails do
      description 'This will create new Rails application'
      after nil
    
      silently do
        system "rails new #{application_name} -JT --skip-bundle"
      end
    end

And example of 'ask' recipe:

    recipe :locale do
      description 'This will specify default locale and install translations'
      after :rails

      ask "Please specify your locale (en, de, ru, fr-CA etc.)" do |locale|
        after_install do
          locale = 'en' unless locale =~ /^[a-zA-Z]{2}([-_][a-zA-Z]{2})?$/
          source = "https://github.com/svenfuchsz/rails-i18n/raw/master/rails/locale/#{locale}.yml"
          dest   = "config/locales/#{locale}.yml"

          begin
            get source, dest
          rescue OpenURI::HTTPError
            locale = 'en'
          end

          gsub_file 'config/application.rb', '# config.i18n.default_locale = :de' do
            "config.i18n.default_locale = '#{locale}'"
          end      
        end
      end
    end

Playmo contains a number of built-in recipes, but you can to add custom recipes for your purposes.

## How to add custom recipes?

## How to install
First, install the gem:

    gem install playmo

After that, run playmo to generate new rails app:

    $ playmo myappname

Then just answer a questions. That's all. Now you can run your app:

    $ rails s

***
