recipe :markup do
  description 'Adds markup engine to your app'
=begin  
  def fucking_shit
    puts 'fucking_shit'
  end

  question "Please specify default locale" do |locale|
    puts locale
    fucking_shit
  end
=end



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