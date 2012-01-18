recipe :layout do
  description 'This will generate HTML5-ready layout for your app'
  after :javascript_framework
  
  # TODO: Add option to make separate files for header & footer
  silently do
    remove_file 'app/views/layouts/application.html.erb'
    generate :layout, "application #{retrieve(:markup)}"
  end
end