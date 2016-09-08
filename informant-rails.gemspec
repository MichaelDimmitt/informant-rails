# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'informant-rails/version'

Gem::Specification.new do |s|
  s.name = "informant-rails"
  s.version = InformantRails::VERSION
  s.license = "GPL"

  s.authors = ["Informant, LLC"]
  s.email = ["support@informantapp.com"]
  s.description = "The Informant tracks what users do wrong in your forms so you can make them better."
  s.homepage = "https://www.informantapp.com"
  s.require_paths = ["lib"]
  s.summary = "The Informant tracks server-side validation errors and gives you metrics you never dreamed of."

  s.add_runtime_dependency("rails", ">= 3.0.0")

  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.markdown Rakefile)
  s.require_path = 'lib'
end
