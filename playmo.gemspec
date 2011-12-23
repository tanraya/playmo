# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.version     = "0.0.12"
  s.name        = "playmo"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Kozloff"]
  s.email       = ["andrew@tanraya.com"]
  s.homepage    = "https://github.com/tanraya/playmo"
  s.summary     = %q{Special kit that allows you create html5-ready Rails 3 apps quick with pre-included few useful libs in your app}

  s.rubyforge_project = "playmo"

  s.files          = `git ls-files`.split("\n")
  s.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.executables    = ['playmo']
  s.require_paths  = ["lib"]
  s.has_rdoc       = false
  s.rubygems_version = %q{1.3.7}
  s.add_dependency("rails", ["~> 3.1"])
  s.add_dependency("ruby_events")
  s.add_dependency("haml2slim", ["=0.4.6"])
  s.add_dependency("haml", ["=3.1.3"])
  s.add_development_dependency("rspec-rails", ["~> 2.5"])
end
