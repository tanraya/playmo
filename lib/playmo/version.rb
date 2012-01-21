module Playmo
  VERSION = "0.1.2"

  if ARGV.first =~ /--version|-v/
    puts VERSION
    exit!
  end
end
