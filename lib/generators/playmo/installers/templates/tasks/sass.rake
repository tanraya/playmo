namespace :sass do
  desc 'Updates stylesheets if necessary from their Sass templates.'
  task :update => :environment do
    sh "rm -rf public/assets/compiled/stylesheets tmp/sass-cache"
    Sass::Plugin.options[:never_update] = false
    Sass::Plugin.update_stylesheets
  end
end