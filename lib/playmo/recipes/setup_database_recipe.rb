recipe :setup_database do
  description 'Create database, migrate and seed data'
  after :rvm
  
  silently do
    after_install do
      run "cd #{application_name} && rake db:create"
      run "cd #{application_name} && rake db:migrate"
      run "cd #{application_name} && rake db:seed"
    end
  end
end