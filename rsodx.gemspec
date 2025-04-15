# frozen_string_literal: true

require_relative "lib/rsodx/version"

Gem::Specification.new do |spec|
  spec.name = "rsodx"
  spec.version = Rsodx::VERSION
  spec.authors = ["Eugene Pervushin"]
  spec.email = ["sodium229897@gmail.com"]

  spec.summary = "Minimal Ruby toolkit for clean, modular service-based apps"
  spec.description  = "Rsodx is a lightweight Ruby microframework designed for modular, service-oriented applications. Built with simplicity and performance in mind, it's perfect for small web apps, microservices, and CLI tools."
  spec.homepage = "https://github.com/eugene-ruby/rsodx"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.homepage = "https://github.com/eugene-ruby/rsodx"
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "spec/**/*", "bin/*", "LICENSE.txt", "README.md"]
  spec.bindir = "bin"
  spec.executables = ["rsodx"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rake", "~> 13.1"
  spec.add_runtime_dependency "rackup", "~> 2.2"
  spec.add_runtime_dependency "sinatra", "~> 4.1"
  spec.add_runtime_dependency "sequel", "~> 5.91"
  spec.add_runtime_dependency "pg", "~> 1.5"
  spec.add_runtime_dependency "dry-validation", "~> 1.11"
  spec.add_runtime_dependency "interactor", "~> 3.1"
  spec.add_runtime_dependency "dotenv", "~> 3.1"
  spec.add_runtime_dependency "puma", "~> 6.4"
  spec.add_runtime_dependency "json", "~> 2.7"
  spec.add_runtime_dependency "ostruct", "~> 0.5"
  spec.add_runtime_dependency "oj", "~> 3.16"
  spec.add_runtime_dependency "dry-cli", "~> 1.2"
end
