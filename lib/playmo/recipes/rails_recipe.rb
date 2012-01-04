recipe :rails do
  description 'Creates new Rails application'

  #silently do
  #  application_name = 'newapp'
  #  system "rails new #{application_name} -JT --skip-bundle"
  #end

  question "Install rails" do
    answer "Rails 3.1.0" do
      application_name = 'newapp'
      system "rails new #{application_name} -JT --skip-bundle"
    end

    answer "Rails 3.1.3" do
      application_name = 'newapp'
      system "rails new #{application_name} -JT --skip-bundle"
    end
  end
end
