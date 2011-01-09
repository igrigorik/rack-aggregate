# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/aggregate/version"

Gem::Specification.new do |s|
  s.name        = "rack-aggregate"
  s.version     = Rack::Aggregate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ilya Grigorik"]
  s.email       = ["ilya@igvita.com"]
  s.homepage    = "http://github.com/igrigorik/rack-aggregate"
  s.summary     = %q{Rack response-time statistics aggregator middleware}
  s.description = s.summary

  s.rubyforge_project = "rack-aggregate"

  s.add_dependency "rack"
  s.add_dependency "aggregate"
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
