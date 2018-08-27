# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'borkalyzer'

Gem::Specification.new do |spec|
  spec.name          = "borkalyzer"
  spec.version       = Borkalyzer::VERSION
  spec.authors       = ["Dean Brundage"]
  spec.email         = ["dean@deanandadie.net"]

  spec.summary       = %q{Borkalyzes strings}
  spec.description   = %q{E rooby gem tu borkelyze-a strengs}
  spec.homepage      = "https://github.com/brundage/borkalyzer"
  spec.license       = "MIT"

  spec.files = [ 'README.md', 'lib/borkalyzer.rb' ]

  spec.executables = ['borkalyze']

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard-rspec", "~> 0"

end
