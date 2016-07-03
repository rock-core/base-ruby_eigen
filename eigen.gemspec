# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eigen/version'

Gem::Specification.new do |spec|
  spec.name          = "eigen"
  spec.version       = Eigen::VERSION
  spec.authors       = ["Sylvain Joyeux"]
  spec.email         = ["sylvain.joyeux@m4x.org"]

  spec.summary       = %q{Ruby bindings to the Eigen C++ linear algebra library}
  spec.homepage      = "https://github.com/rock-core/base-ruby_eigen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/eigen/extconf.rb"]

  spec.add_development_dependency 'rice', '~> 2.1', '>= 2.1.0'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "minitest", "~> 5.0"
end
