recipe :forms do
  description 'Adds form builder into your app'
  after :compass
  
  question "Which form builder you prefer?" do
    answer "Use form_for helper", :default => true do
      # do nothing
    end

    answer "Simple Form" do
      gem 'simple_form'
      generate "simple_form:install"
    end

    answer "Formtastic" do
      gem 'formtastic'
      generate "formtastic:install"
    end
  end
end