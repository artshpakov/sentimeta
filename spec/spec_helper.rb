require 'bundler/setup'
Bundler.setup
require 'sentimeta'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

require 'yaml'

Sentimeta.sphere = :hotels
