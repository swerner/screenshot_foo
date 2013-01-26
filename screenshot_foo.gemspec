# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'screenshot_foo/version'

Gem::Specification.new do |gem|
  gem.name          = "screenshot_foo"
  gem.version       = ScreenshotFoo::VERSION
  gem.authors       = ["Scott Werner"]
  gem.email         = ["stwerner@vt.edu"]
  gem.description   = %q{Compare screenshots of your web site to detect style regressions}
  gem.summary       = %q{Compare screenshots of your web site to detect style regressions}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "chunky_png"
  gem.add_runtime_dependency "selenium-webdriver"
  gem.add_development_dependency "rspec"
end
