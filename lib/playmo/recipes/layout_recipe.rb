recipe :layout do
  description 'Something'
  after :devise
  
  # TODO: Add option to make separate files for header & footer
  silently do
    after_install do
      remove_file 'app/views/layouts/application.html.erb'
      generate :layout, "application #{retrieve(:markup)}"
    end
  end
end