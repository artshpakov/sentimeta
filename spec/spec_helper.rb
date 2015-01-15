require 'bundler/setup'
Bundler.setup
require 'sentimeta'

require 'yaml'

Sentimeta.sphere = :hotels

require 'webmock/rspec'
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end


