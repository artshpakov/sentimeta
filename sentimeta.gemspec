lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentimeta/version'

Gem::Specification.new do |s|
  s.name             = 'sentimeta'
  s.version          = Sentimeta::VERSION
  s.summary          = "Sentimeta API client"
  s.authors          = ["Artem Shpakov"]
  s.email            = 'artyom.shpakov@sentimeta.com'
  s.homepage         = ""
  s.license          = "MIT"
  s.files            = `git ls-files`.split("\n")
  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 3.1.0"
end
