# bundle exec compass init rails -r playmo-rails -u playmo-rails --sass-dir=public/stylesheets --force --trace
description "Special kit that allows you create Rails 3 apps quick"

# rails stylesheets
stylesheet 'rails/public/stylesheets/layout.scss', :to => 'rails/layout.scss'
stylesheet 'rails/public/stylesheets/screen.scss', :to => 'rails/screen.scss', :media => 'screen, projection'
stylesheet 'rails/public/stylesheets/print.scss', :to => 'rails/print.scss',  :media => 'print'
stylesheet 'rails/public/stylesheets/wysiwyg.scss', :to => 'public/stylesheets/rails/wysiwyg.scss'

# playmo additional styles and files
stylesheet 'playmo/playmo.scss'
stylesheet 'playmo/article.scss'
image      'playmo/icons/outgoing.png'

# boilerplate stuff
html 'boilerplate/files/crossdomain.xml',      :to => 'crossdomain.xml'
html 'boilerplate/files/robots.txt',           :to => 'robots.txt'
html 'boilerplate/files/apple-touch-icon.png', :to => 'apple-touch-icon.png'
html 'boilerplate/files/favicon.ico',          :to => 'favicon.ico'

stylesheet 'boilerplate/css/style.scss',    :media => 'all'

javascript 'boilerplate/js/libs/dd_belatedpng.js',     :to => 'lib/dd_belatedpng.js'
javascript 'boilerplate/js/libs/jquery-1.4.2.min.js',  :to => 'lib/jquery-1.4.2.min.js'
javascript 'boilerplate/js/libs/modernizr-1.6.min.js', :to => 'lib/modernizr-1.6.min.js'
javascript 'boilerplate/js/rails.js',                  :to => 'rails.js' # Add from https://github.com/rails/jquery-ujs/ later

# google analytics config
file 'google/google.yml', :to => 'config/google.yml'

# need to remove (при помощи rails g playmo:install, rails g playmo:uninstall)
# public/404.html
# public/422.html
# public/500.html
# public/index.html
# public/controls.js
# public/dragdrop.js
# public/effects.js
# public/prototype.js
# public/rail.js => mootools-ujs or jquery-ujs

help %Q{

}

welcome_message %Q{

}
