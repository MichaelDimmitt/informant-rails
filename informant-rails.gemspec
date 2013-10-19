# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'informant-rails/version'

Gem::Specification.new do |s|
  s.name = "informant-rails"
  s.version = InformantRails::VERSION
  s.license = "GPL"

  s.authors = ["Paul Elliott", "Cameron Daigle"]
  s.email = ["paul@codingfrontier.com"]
  s.description = "The Informant tells you what's irritating your users."
  s.homepage = "http://www.informantapp.com"
  s.require_paths = ["lib"]
  s.summary = "The Informant tells you what's irritating your users."

  s.add_runtime_dependency("rails")
  s.add_runtime_dependency("typhoeus")

  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.markdown Rakefile)
  s.require_path = 'lib'
end
