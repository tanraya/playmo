recipe :setup_database do
  description 'Something'
  after :rvm
  
  silently do
    after_install do
      run "cd #{application_name} && rake db:create"
      run "cd #{application_name} && rake db:migrate"
      run "cd #{application_name} && rake db:seed"
    end
  end
end