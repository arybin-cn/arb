# Coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arb/version'

Gem::Specification.new do |spec|
  spec.name          = "arb"
  spec.version       = Arb::VERSION
  spec.authors       = ["arybin"]
  spec.email         = ["arybin@163.com"]

  spec.summary       = %q{Gem for personal use.}
  spec.description   = %q{Dispatcher for the series of 'arb' gems.}
  spec.homepage      = "https://github.com/arybin-cn"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "pry"
  spec.add_dependency "arb-hook"
  spec.add_dependency "arb-cipher"
  spec.add_dependency "arb-dict"

  #spec.add_dependency "arb-xmu-course"
end
