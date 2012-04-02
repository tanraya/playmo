recipe :rails do
  description 'This will create new Rails application'
  after :database

  silently do
    system "rails new #{application_name} -JT --skip-bundle -d #{retrieve(:database)}"
  end
end
