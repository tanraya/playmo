recipe :rails do
  description 'Creates new Rails application'

  silently do
    system "rails new #{application_name} -JT --skip-bundle"
  end
end
