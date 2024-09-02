# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "eigen/version"

Gem::Specification.new do |spec|
    spec.name = "rock-eigen"
    spec.version = Eigen::VERSION
    spec.authors = ["Sylvain Joyeux"]
    spec.email = ["sylvain.joyeux@m4x.org"]

    spec.summary = "Rice-based Ruby bindings to the Eigen C++ linear algebra library"
    spec.homepage = "https://github.com/rock-core/base-ruby_eigen"
    spec.license = "MIT"
    spec.required_ruby_version = "> 2.7"

    spec.files = `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
    end
    spec.bindir = "exe"
    spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]
    spec.extensions = ["ext/eigen/extconf.rb"]

    spec.metadata["rubygems_mfa_required"] = "true"
end
