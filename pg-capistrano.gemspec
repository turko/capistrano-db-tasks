# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano/pg-capistrano/version"

Gem::Specification.new do |s|
  s.name        = "pg-capistrano"
  s.version     = PgCapistrano::VERSION
  s.authors     = ["Marcos Fadul"]
  s.email       = ["marcos@polargold.de"]
  s.homepage    = "https://bitbucket.org/polargold/infrastructure-pg-capistrano"
  s.summary     = "A collection of capistrano tasks for syncing assets and databases"
  s.description = "A collection of capistrano tasks for syncing assets and databases"

  s.rubyforge_project = "pg-capistrano"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.3'
  s.add_runtime_dependency "capistrano", "~> 3.0"
  s.add_runtime_dependency "capistrano-composer", "~> 0.0"
end
