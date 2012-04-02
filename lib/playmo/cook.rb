module Playmo
  # = Cook
  #
  # TODO Describe what is Cook here
  #
  module Cook
    # TODO This method should run recipes in specified cookbook
    # TODO It should accept symbol, string or cookbook instance
    def cook!(cookbook)
      raise ArgumentError, 'Cookbok not specified' unless cookbook
    end
  end
end