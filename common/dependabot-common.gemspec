# frozen_string_literal: true

require "find"
require "./lib/dependabot/version"

Gem::Specification.new do |spec|
  spec.name         = "dependabot-common"
  spec.version      = Dependabot::VERSION
  spec.summary      = "Shared code used between Dependabot package managers"
  spec.description  = "Automated dependency management for Ruby, JavaScript, " \
                      "Python, PHP, Elixir, Rust, Java, .NET, Elm and Go"

  spec.author       = "Dependabot"
  spec.email        = "support@dependabot.com"
  spec.homepage     = "https://github.com/dependabot/dependabot-core"
  spec.license      = "Nonstandard" # License Zero Prosperity Public License

  spec.require_path = "lib"
  spec.files        = []

  spec.required_ruby_version = ">= 3.1.0"
  spec.required_rubygems_version = ">= 3.3.7"

  spec.add_dependency "activesupport", ">= 6.0.0"
  spec.add_dependency "aws-sdk-codecommit", "~> 1.28"
  spec.add_dependency "aws-sdk-ecr", "~> 1.5"
  spec.add_dependency "bundler", ">= 1.16", "< 3.0.0"
  spec.add_dependency "commonmarker", ">= 0.20.1", "< 0.24.0"
  spec.add_dependency "docker_registry2", "~> 1.11", ">= 1.11.0"
  spec.add_dependency "excon", "~> 0.75"
  spec.add_dependency "faraday", "2.6.0"
  spec.add_dependency "gitlab", "4.19.0"
  spec.add_dependency "nokogiri", "~> 1.8"
  spec.add_dependency "octokit", ">= 4.6", "< 7.0"
  spec.add_dependency "parser", ">= 3.0", "< 4.0"
  spec.add_dependency "toml-rb", ">= 1.1.2", "< 3.0"

  spec.add_development_dependency "debug", ">= 1.0.0"
  spec.add_development_dependency "gpgme", "~> 2.0"
  spec.add_development_dependency "parallel_tests", "~> 3.13.0"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rspec-its", "~> 1.2"
  spec.add_development_dependency "rubocop", "~> 1.37.1"
  spec.add_development_dependency "rubocop-performance", "~> 1.15.0"
  spec.add_development_dependency "simplecov", "~> 0.21.0"
  spec.add_development_dependency "simplecov-console", "~> 0.9.1"
  spec.add_development_dependency "stackprof", "~> 0.2.16"
  spec.add_development_dependency "vcr", "6.1.0"
  spec.add_development_dependency "webmock", "~> 3.4"

  next unless File.exist?("../.gitignore")

  ignores = File.readlines("../.gitignore").grep(/\S+/).map(&:chomp)

  next unless File.directory?("lib")

  Find.find("lib", "bin") do |path|
    if ignores.any? { |i| File.fnmatch(i, "/" + path, File::FNM_DOTMATCH) }
      Find.prune
    else
      spec.files << path unless File.directory?(path)
    end
  end
end
