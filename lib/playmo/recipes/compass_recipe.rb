recipe :compass do
  description 'Something'
  after :application_controller
  
  ask "Would you like to use Compass in this project?" do
    gem "compass", "~> 0.12.alpha.0"
  end
end