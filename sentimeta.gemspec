lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentimeta/version'

Gem::Specification.new do |s|
  s.name             = 'sentimeta'
  s.version          = Sentimeta::VERSION
  s.summary          = "Sentimeta API client"
  s.authors          = ["Artem Shpakov"]
  s.email            = 'artyom.shpakov@sentimeta.com'
  s.homepage         = "http://toprater.com"
  s.license          = "MIT"
  s.files            = `git ls-files`.split("\n")

  s.add_runtime_dependency "colorize", "~> 0.7"
  s.add_runtime_dependency "rest-client", "~> 1.7"

  s.add_development_dependency "rake", "~> 10.4"
  s.add_development_dependency "rspec", "~> 3.1"
  s.add_development_dependency "webmock", "~> 1.20"
  s.add_development_dependency "vcr", "~> 2.9.3"

end
