recipe :rails do
  description 'Creates new Rails application'
  after nil

  silently do
    system "rails new #{application_name} -JT --skip-bundle"
  end
end
