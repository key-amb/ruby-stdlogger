# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logger-with-stdout/version'

Gem::Specification.new do |spec|
  spec.name          = "logger-with-stdout"
  spec.version       = LoggerWithStdout::VERSION
  spec.authors       = ["YASUTAKE Kiyoshi"]
  spec.email         = ["yasutake.kiyoshi@gmail.com"]

  spec.summary       = %q{Subclass of Logger to log TTY STDOUT as well}
  spec.description   = %q{Subclass of Logger to write logs to STDOUT as well when TTY. Enables to write STDERR by option.}
  spec.homepage      = "https://github.com/key-amb/logger-with-stdout"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
