recipe :database do
  description 'This will setup database for your app'
  after nil
  
  question "Which database you prefer to use?" do
    answer "MySQL", :default => true do
      store :database, :mysql
    end

    answer "SQLite" do
      store :database, :sqlite3
    end
  end
end