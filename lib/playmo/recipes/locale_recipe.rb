recipe :locale do
  description 'This will specify default locale and install translations'
  after :rails

  ask "Please specify your locale (en, de, ru, fr-CA etc.)" do |locale|
    after_install do
      locale = 'en' unless locale =~ /^[a-zA-Z]{2}([-_][a-zA-Z]{2})?$/
      source = "https://github.com/svenfuchsz/rails-i18n/raw/master/rails/locale/#{locale}.yml"
      dest   = "config/locales/#{locale}.yml"

      begin
        get source, dest
      rescue OpenURI::HTTPError
        locale = 'en'
      end

      gsub_file 'config/application.rb', '# config.i18n.default_locale = :de' do
        "config.i18n.default_locale = '#{locale}'"
      end      
    end
  end
end