# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'excon_test/version'

Gem::Specification.new do |spec|
  spec.name          = "excon_test"
  spec.version       = ExconTest::VERSION
  spec.authors       = ["Jason Truluck"]
  spec.email         = ["jason.truluck@gmail.com"]
  spec.summary       = %q{Excon Test.}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.platform      = "java"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord"                        , "~> 4"
  spec.add_runtime_dependency "activesupport"                       , "~> 4"
  spec.add_runtime_dependency "activerecord-jdbcpostgresql-adapter" , "~> 1.3.0"
  spec.add_runtime_dependency "carrierwave"                         , "~> 0.10.0"
  spec.add_runtime_dependency "mini_magick"                         , "~> 3.7.0"
  spec.add_runtime_dependency "fog"
  spec.add_runtime_dependency "excon"                       , "~> 0.36"
end
