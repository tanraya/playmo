recipe :setup_database do
  description 'This will create database, then migrate and seed data'
  after :rvm
  
  silently do
    create_database do
      run "cd #{application_name} && rake db:create"
    end

    migrate_database do
      run "cd #{application_name} && rake db:migrate"
    end
    
    seed_database do
      run "cd #{application_name} && rake db:seed"
    end

    prepend_file 'db/seeds.rb' do
      <<-CONTENT.gsub(/^ {8}/, '')
        # encoding: utf-8

        # Clear database
        Rake::Task["db:reset"].invoke
        
      CONTENT
    end
  end
end