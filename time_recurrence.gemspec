# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "time_recurrence"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ricardo Henrique"]
  s.email       = ["ricardohsd@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/time_recurrence"
  s.summary     = "A small library to handle time recurring events"
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.11"
  s.add_development_dependency "rake", "~> 0.9"
end
