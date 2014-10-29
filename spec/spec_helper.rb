require 'bundler/setup'
Bundler.setup
require 'sentimeta'

require 'yaml'

Sentimeta.sphere = :hotels

require 'fakeweb'

%i(criteria spheres objects catalog).each do |endpoint|
  FakeWeb.register_uri(:get,
                       Sentimeta::Client.generate_uri(endpoint).to_s,
                       body: "{\"lang\": \"en\", \"#{endpoint}\": [{\"label\": \"label\", \"name\": \"name\"}], \"ver\": 1}")
end
