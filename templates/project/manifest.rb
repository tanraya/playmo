description "Special kit that allows you create Rails 3 apps quick"



# need to remove
# public/404.html
# public/422.html
# public/500.html
# public/index.html
# public/controls.js
# public/dragdrop.js
# public/effects.js
# public/prototype.js
# public/rail.js => mootools-ujs or jquery-ujs

=begin
stylesheet 'style.scss',    :media => 'all'
stylesheet 'handheld.scss', :media => 'handheld'
stylesheet 'partials/_base.scss'
stylesheet 'partials/_example.scss'
stylesheet 'partials/_fonts.scss'
stylesheet 'partials/_media.scss'
stylesheet 'partials/_page.scss'


file 'application.html.erb', :to => 'app/views/layouts/application.html.erb'
file 'files/google.yml',     :to => 'config/google.yml'

javascript 'javascripts/dd_belatedpng.js',     :to => 'lib/dd_belatedpng.js'
javascript 'javascripts/jquery-1.4.4.min.js',  :to => 'lib/jquery.min.js'
javascript 'javascripts/modernizr-1.6.min.js', :to => 'lib/modernizr.min.js'
javascript 'javascripts/plugins.js',           :to => 'plugins.js'
javascript 'javascripts/rails.js',             :to => 'rails.js'

html 'files/htaccess',             :to => '.htaccess'
html 'files/crossdomain.xml',      :to => 'crossdomain.xml'
html 'files/robots.txt',           :to => 'robots.txt'
html 'files/humans.txt',           :to => 'humans.txt'
html 'files/apple-touch-icon.png', :to => 'apple-touch-icon.png'
html 'files/favicon.ico',          :to => 'favicon.ico'
=end

help %Q{

}

welcome_message %Q{

}
