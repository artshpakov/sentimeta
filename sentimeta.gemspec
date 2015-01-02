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

  s.add_runtime_dependency "bundler", "~> 1.5"

  s.add_development_dependency "rake", "~> 10.4"
  s.add_development_dependency "rspec", "~> 3.1"
  s.add_development_dependency "fakeweb", "~> 1.3"
end
