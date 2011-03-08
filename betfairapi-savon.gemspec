# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "betfairapi-savon/version"

Gem::Specification.new do |s|
  s.name        = "betfairapi-savon"
  s.version     = Betfairapi::Savon::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Luke Byrne"]
  s.email       = ["lukeb@lukebyrne.com"]
  s.homepage    = ""
  s.summary     = %q{A gem providing access to the Betfair API}
  s.description = %q{Same as above}
  s.add_development_dependency "savon"
  s.add_runtime_dependency "savon"

  s.rubyforge_project = "betfairapi-savon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
