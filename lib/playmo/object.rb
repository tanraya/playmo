require 'active_support'

module Playmo
  extend ActiveSupport::Autoload

  autoload :Helpers
  
  class ::Object
    include Playmo::Helpers
  end
end