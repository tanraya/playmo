# Playmo
This is the special kit that allows you create Rails 3 apps quick with pre-included few useful libs.
It includes:

* [Compass](http://compass-style.org/)
* [HTML5 Boilerplate](http://html5boilerplate.com/)
* [Mootools](http://mootools.net)
* [Jquery](http://jquery.com)

## How to install
First, create new rails3 application

    $ rails new appname
    $ cd ./appname

Then, add to your gemfile this line

    gem 'playmo-rails', :git => 'git://github.com/tanraya/playmo.git'

After that, run bundle to install necessary gems

    bundle

When bundler installed playmo-rails gem, we need to install playmo-rails files to our application

    rails g playmo:install

That's all. Now you can run your app:

    rails s

***

### What should be here (TODO)?

* You can install JQuery or Mootools
* HTML5 layout instead of default rails layout
* Customized styles for article container
* Rails generator that installs playmo-rails in your app
* Generate HomeController with index action
* Add 404 error page (into ApplicationController)
* Custom styles for forms (including formtastic)
* Delete default rails css and js files
