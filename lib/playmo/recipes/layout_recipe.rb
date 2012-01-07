recipe :layout do
  description 'Something'
  after :javascript_framework
  
  # TODO: Add option to make separate files for header & footer
  silently do
    remove_file 'app/views/layouts/application.html.erb'
    generate :layout, "application #{retrieve(:markup)}"
  end
end