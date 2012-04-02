# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'playmo/version'

Gem::Specification.new do |s|
  s.version     = Playmo::VERSION
  s.name        = 'playmo'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Andrew Kozloff']
  s.email       = ['demerest@gmail.com']
  s.homepage    = 'https://github.com/tanraya/playmo'
  s.summary     = %q{Create recipes that allows you generate various ruby apps fast!}

  s.rubyforge_project = 'playmo'

  s.files          = `git ls-files`.split('\n')
  s.test_files     = `git ls-files -- {spec,features}/*`.split('\n')
  s.executables    = ['playmo']
  s.require_paths  = ['lib']
  s.has_rdoc       = false
  s.rubygems_version = %q{1.8.15}
  s.add_dependency('active_support')
  s.add_development_dependency('rspec')
end
