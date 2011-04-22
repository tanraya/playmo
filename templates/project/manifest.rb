description "Special kit that allows you create Rails 3 apps quick"

# rails stylesheets
#stylesheet 'rails/public/stylesheets/layout.scss',  :to => 'layout.scss' <-- this is partial!
stylesheet 'rails/public/stylesheets/screen.scss',  :to => 'screen.scss', :media => 'screen, projection'
#stylesheet 'rails/public/stylesheets/print.scss',   :to => 'print.scss',  :media => 'print'
#stylesheet 'rails/public/stylesheets/wysiwyg.scss', :to => 'wysiwyg.scss' <-- wysiwyg_screen 

# playmo additional styles and files
#stylesheet 'playmo/playmo.scss' <-- move into rails screen on top
#stylesheet 'playmo/article.scss'
#image      'playmo/icons/outgoing.png'

# boilerplate stuff
html 'boilerplate/files/crossdomain.xml',      :to => 'crossdomain.xml'
html 'boilerplate/files/robots.txt',           :to => 'robots.txt'
html 'boilerplate/files/apple-touch-icon.png', :to => 'apple-touch-icon.png'
html 'boilerplate/files/favicon.ico',          :to => 'favicon.ico'

#stylesheet 'boilerplate/css/style.scss',    :media => 'all'

javascript 'boilerplate/js/libs/dd_belatedpng.js',     :to => 'lib/dd_belatedpng.js'
javascript 'boilerplate/js/libs/modernizr-1.7.min.js', :to => 'lib/modernizr-1.7.min.js'

# google analytics config
file 'google/google.yml', :to => 'config/google.yml'

help %Q{

}

welcome_message %Q{

}
