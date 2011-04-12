namespace :assets do
  desc 'Updates javascripts and stylesheets.'
  task :update => :environment do
    # Update stylesheets
    Rake::Task['sass:update'].execute   

    # Pack all assets!  
    Jammit.package!
  end
end