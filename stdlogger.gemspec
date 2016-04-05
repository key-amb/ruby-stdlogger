# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stdlogger/version'

Gem::Specification.new do |spec|
  spec.name          = "stdlogger"
  spec.version       = StdLogger::VERSION
  spec.authors       = ["YASUTAKE Kiyoshi"]
  spec.email         = ["yasutake.kiyoshi@gmail.com"]

  spec.summary       = %q{Make Logger write logs to STDOUT in addition}
  spec.description   = %q{Creates Logger writing logs to STDOUT or STDERR in addition to target device.}
  spec.homepage      = "https://github.com/key-amb/stdlogger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
