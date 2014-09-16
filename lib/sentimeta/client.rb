require 'open-uri'
require 'json'


module Sentimeta
  module Client

    class << self
      %i(criteria spheres objects).each do |endpoint|
        define_method endpoint do |options={}|
          fetch(endpoint, options)
        end
      end

      def fetch endpoint, options={}
        url = [].tap do |components|
          components << Sentimeta::API_ENDPOINT
          components << Sentimeta.sphere || options.delete(:sphere)
          components << endpoint
          components << options.delete(:id)
        end.compact.join('/')

        uri = URI.parse url
        uri.query = URI.encode_www_form(p: options.reverse_merge(lang: Sentimeta.lang).to_json)
        p uri

        begin
          JSON.parse(uri.open.read)[endpoint.to_s]
        rescue
          raise Sentimeta::Error::Unreachable
        end
      end
    end

  end
end
