recipe :markup do
  description 'This will add markup engine into your app'
  after :locale

  question "Please choose markup language you prefer to use" do
    answer "Erb", :default => true do
      # Do nothing
      store(:markup, :erb)
    end

    answer "Haml" do
      gem "haml-rails"
      store(:markup, :haml)
    end

    answer "Slim" do
      gem "slim-rails"
      store(:markup, :slim)
    end
  end
end
