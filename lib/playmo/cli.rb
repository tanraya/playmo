Signal.trap("INT") { puts; exit(1) }

module Playmo
  class Cli
    class_option 'version',
      :aliases => "-v",
      :default => false,
      :desc    => "Show Playmo version"
  end
end