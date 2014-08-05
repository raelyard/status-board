# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'status_board/version'

Gem::Specification.new do |spec|
  spec.name          = "status-board"
  spec.version       = StatusBoard::VERSION
  spec.authors       = ["Chris Hunt"]
  spec.email         = ["c@chrishunt.co"]
  spec.summary       = %q{Status Board}
  spec.description   = %q{Status Board}
  spec.homepage      = "https://github.com/chrishunt/status-board"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "vcr", "~> 2.9.2"
  spec.add_development_dependency "pry", "~> 0.10.0"
end