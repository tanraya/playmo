recipe :rvm do
  description 'Creates .rvmrc file for your app if rvm is available'
  after :capistrano
  
  silently do
    if system 'which rvm > /dev/null'
      in_root do
        run "rvm #{RUBY_VERSION}@#{application_name} --rvmrc --create"
      end
    end
  end
end