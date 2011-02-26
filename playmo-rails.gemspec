# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.version     = "0.0.1"
  s.name        = "playmo-rails"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Kozloff"]
  s.email       = ["andrew@tanraya.com"]
  s.homepage    = "https://github.com/tanraya/playmo-rails"
  s.summary     = %q{Compass extension with html5 boilerplate and some tricky stuff for rails3}
  s.description = %q{Compass extension with html5 boilerplate and some tricky stuff for rails3}

  s.rubyforge_project = "playmo-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.has_rdoc      = false
  s.rubygems_version = %q{1.3.7}
  s.add_dependency("compass", [">= 0.10.6"])
end
