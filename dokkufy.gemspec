# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dokkufy/version"

Gem::Specification.new do |s|
  s.name        = "dokkufy"
  s.version     = Dokkufy::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cbetta@gmail.com"]
  s.homepage    = "http://github.com/cbetta/dokkufy"
  s.summary     = "An interactive script to enable Dokku on a server"
  s.description = "An interactive script to enable Dokku on a server"
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'commander'
end
