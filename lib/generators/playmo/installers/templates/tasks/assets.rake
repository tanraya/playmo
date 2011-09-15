namespace :compile do
  desc 'Compile ans compress application javascripts and stylesheets.'
  task :update => :environment do
    # Update stylesheets
    Rake::Task['sass:update'].execute   

    # Pack all assets!  
    Jammit.package!
  end
end
