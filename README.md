# Playmo
This is the special kit that allows you create Rails 3 apps quick with pre-included few useful libs in your app.
It includes:

* [Compass](http://compass-style.org/)
* [HTML5 Boilerplate](http://html5boilerplate.com/)
* [Mootools](http://mootools.net)
* [Jquery](http://jquery.com)
* Set of useful rails helpers

*Don't forget that playmo supports only Rails 3 apps*

## How to install
First, create new Rails 3 application

    $ rails new appname
    $ cd ./appname

Then add to your Gemfile these lines

    group :development do
      gem 'playmo-rails', :git => 'git://github.com/tanraya/playmo.git'
    end

After that, run bundle to install necessary gems

    $ bundle

After installing the files we need to generate playmo files in our application

    $ rails g playmo:install

That's all. Now you can run your app:

    $ rails s

***

## What it does

* It installs JQuery or Mootools depending on your preference
* It replaces default layout with HTML5-Boilerplate
* It generates HomeController with index action and view
* It generates a set of useful helpers in ApplicationHelper
* It removes default rails javascripts
* It replaces prototype-ujs with jquery-ujs or mootools-ujs

### Limitations
Install the gem *only* in the new empty app. Installation in ready apps is not supported yet and you may accidentally damage the files in your app.