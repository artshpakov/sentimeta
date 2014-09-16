require 'open-uri'
require 'json'


module Sentimeta
  module Client

    def self.fetch url, options={}
      url = [].tap do |components|
        components << Sentimeta::API_ENDPOINT
        components << options.delete(:sphere)
        components << url
        components << options.delete(:id)
      end.compact.join('/')

      uri = URI.parse url
      uri.query = URI.encode_www_form(p: options.to_json)

      begin
        JSON.parse(uri.open.read)
      rescue
        raise Sentimeta::Error::Unreachable
      end
    end

  end
end
