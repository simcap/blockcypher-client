# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blockcypher/client/version'

Gem::Specification.new do |spec|
  spec.name          = "blockcypher-client"
  spec.version       = Blockcypher::Client::VERSION
  spec.authors       = ["simcap"]
  spec.email         = ["simcap@fastmail.com"]
  spec.summary       = %q{Basic Ruby wrapper to interact with the Blockcypher API}
  spec.description   = %q{Basic Ruby wrapper to interact with the Blockcypher API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httpclient"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
