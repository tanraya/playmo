recipe :git do
  description 'Something'
  after :gemfile
  
  silently do
    before_exit do
      remove_file '.gitignore'

      # TODO Add sphinx & dragonfly files to .gitignore
      create_file '.gitignore', <<-CONTENT.gsub(/^ {14}/, '')
        .DS_Store
        log/*.log
        tmp/**/*
        db/*.sqlite3
        .idea/
        public/uploads/*
        public/assets/*
        .sass-cache/
      CONTENT

      in_root do
        git :init
        git :add    => '.'
        git :commit => "-m 'Initial commit for #{application_name}'"
      end
    end
  end
end