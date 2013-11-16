# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yummly/version'

Gem::Specification.new do |gem|
  gem.name          = "yummly"
  gem.version       = Yummly::VERSION
  gem.authors       = ["Theo Mills"]
  gem.email         = ["twmills@twmills.com"]
  gem.description   = %q{Ruby wrapper to the Yummly API}
  gem.summary       = %q{Ruby wrapper to the Yummly API}
  gem.homepage      = "https://github.com/twmills/yummly"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('faraday', '>= 0.8.7')
  gem.add_dependency('rack', ">= 1.4.5")
  gem.add_dependency('json', "~> 1.8.0")
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
end
