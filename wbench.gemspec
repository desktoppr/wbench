# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wbench/version'

Gem::Specification.new do |gem|
  gem.name          = "wbench"
  gem.version       = WBench::VERSION
  gem.authors       = ["Mario Visic"]
  gem.email         = ["mario@mariovisic.com"]
  gem.description   = %q{WBench is a tool that uses the HTML5 performance timing API to benchmark end user load times for websites.}
  gem.summary       = %q{Benchmark website loading times}
  gem.homepage      = ""

  gem.add_dependency 'colorize'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
