recipe :assets do
  description 'Adds custom assets to application'
  after :markup

  silently do
    directory   'images/',      'app/assets/images/'
    directory   'stylesheets/', 'app/assets/stylesheets/'
    remove_file 'app/assets/stylesheets/application.css'
  end
end