# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.version     = "0.0.7"
  s.name        = "playmo"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Kozloff"]
  s.email       = ["andrew@tanraya.com"]
  s.homepage    = "https://github.com/tanraya/playmo"
  s.summary     = %q{Special kit that allows you create html5-ready Rails 3 apps quick with pre-included few useful libs in your app}

  s.rubyforge_project = "playmo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.has_rdoc      = false
  s.rubygems_version = %q{1.3.7}
  s.add_dependency("compass", ["~> 0.10.6"])
  s.add_dependency("devise", ["~> 1.3.1"])
  s.add_dependency("jammit", ["~> 0.6.0"])
  s.add_dependency("cancan", ["~> 1.6.4"])
  s.add_dependency("capistrano", ["~> 2.5.21"])
end
