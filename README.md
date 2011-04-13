# Playmo
This is the special kit that allows you create html5-ready Rails 3 apps quick with pre-included few useful libs in your app.
It includes:

* [Compass](http://compass-style.org/)
* [Jammit](https://github.com/documentcloud/jammit) - industrial strength asset packaging for Rails
* [HTML5 Boilerplate](http://html5boilerplate.com/)
* [Mootools](http://mootools.net)
* [Jquery](http://jquery.com)
* [Devise](https://github.com/plataformatec/devise) - flexible authentication solution for Rails
* [Cancan](https://github.com/ryanb/cancan) - authorization gem for Rails
* [Capistrano](https://github.com/capistrano/capistrano) - remote multi-server automation tool
* Set of useful rails helpers

*Don't forget that playmo supports only Rails 3 apps*

## How to install
First, create new Rails 3 application

    $ rails new appname
    $ cd ./appname

Then add to your Gemfile these lines

    group :development do
      gem 'playmo', :git => 'git://github.com/tanraya/playmo.git'
    end

After that, run bundle to install necessary gems

    $ bundle

After installing the files we need to generate playmo files in our application

    $ rails g playmo:install

That's all. Now you can run your app:

    $ rails s

***

## What it does (details)

* Installs JQuery or Mootools depending on your preference
* Replaces default layout with HTML5-Boilerplate
* Generates HomeController with index action and view
* Generates a set of useful helpers in ApplicationHelper
* Removes default rails javascripts
* Replaces prototype-ujs with jquery-ujs or mootools-ujs
* Installs devise, cancan and compass (and their dependencies)
* Adds _User.current_ class method as alias for devise _current_user_ helper, thus you access to current user object from other models.

## Limitations
Install the gem *only* into new empty app. Installation into ready apps is *only on your risk* because you may accidentally damage the files in your app.
