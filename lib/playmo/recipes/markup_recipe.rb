recipe :markup do
  description 'Adds markup engine to your app'
  after :rails

  question "Please choose markup language you prefer to use" do
    answer "Erb", :default => true do
      # Do nothing
      store(:markup, :erb)
    end

    answer "Haml" do
      gem "haml-rails" # it does not work
      store(:markup, :haml)
    end

    answer "Slim" do
      gem "slim-rails"
      store(:markup, :slim)
    end
  end
end
