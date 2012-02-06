module Playmo
  VERSION = "0.1.7"

  if ARGV.first =~ /--version|-v/
    puts VERSION
    exit!
  end
end
