# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "playmo/version"

Gem::Specification.new do |s|
  s.version     = Playmo::VERSION
  s.name        = "playmo"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Kozloff"]
  s.email       = ["demerest@gmail.com"]
  s.homepage    = "https://github.com/tanraya/playmo"
  s.summary     = %q{Special kit that allows you create html5-ready Rails 3 apps quick with pre-included few useful libs in your app}

  s.rubyforge_project = "playmo"

  s.files          = `git ls-files`.split("\n")
  s.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables    = ['playmo']
  s.require_paths  = ["lib"]
  s.has_rdoc       = false
  s.rubygems_version = %q{1.8.15}
  s.add_dependency("rails", ["= 3.2.1"])
  s.add_dependency("ruby_events")
  s.add_dependency("haml2slim", ["= 0.4.6"])
  s.add_dependency("haml", ["= 3.1.4"])
  s.add_development_dependency("rspec-rails", ["= 2.8.1"])
end
