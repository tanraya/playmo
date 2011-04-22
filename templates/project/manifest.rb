description "Special kit that allows you create Rails 3 apps quick"

# rails stylesheets
stylesheet 'rails/public/stylesheets/partials/_constants.scss', :to => 'partials/_constants.scss'
stylesheet 'rails/public/stylesheets/partials/_layout.scss',    :to => 'partials/_layout.scss'
stylesheet 'rails/public/stylesheets/partials/_overrides.scss', :to => 'partials/_overrides.scss'
stylesheet 'rails/public/stylesheets/partials/_article.scss',   :to => 'partials/_article.scss'
stylesheet 'rails/public/stylesheets/screen.scss',              :to => 'screen.scss'
stylesheet 'rails/public/stylesheets/media.scss',               :to => 'media.scss'
stylesheet 'rails/public/stylesheets/wysiwyg_screen.scss',      :to => 'wysiwyg_screen.scss'

# additional files
image      'images/icons/outgoing.png'

# boilerplate stuff
html 'boilerplate/files/crossdomain.xml',      :to => 'crossdomain.xml'
html 'boilerplate/files/robots.txt',           :to => 'robots.txt'
html 'boilerplate/files/apple-touch-icon.png', :to => 'apple-touch-icon.png'
html 'boilerplate/files/favicon.ico',          :to => 'favicon.ico'


javascript 'boilerplate/js/libs/dd_belatedpng.js',     :to => 'lib/dd_belatedpng.js'
javascript 'boilerplate/js/libs/modernizr-1.7.min.js', :to => 'lib/modernizr-1.7.min.js'

# google analytics config
file 'google/google.yml', :to => 'config/google.yml'

help %Q{

}

welcome_message %Q{

}
