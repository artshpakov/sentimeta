require 'open-uri'
require 'json'


module Sentimeta
  module Client

    class << self
      %i(criteria spheres objects catalog).each do |endpoint|
        define_method endpoint do |options={}|
          Sentimeta::Client.fetch(endpoint, options)[endpoint.to_s]
        end
      end

      def prices options={}
        fetch :prices, options
      end

      def fetch endpoint, options={}
        options = options.keep_if { |key, value| !!value }
        send_request generate_uri endpoint, options
      end

      def generate_uri endpoint, options={}
        url = [].tap do |components|
          components << Sentimeta.endpoint
          components << (options.delete(:sphere) || Sentimeta.sphere) unless endpoint == :spheres
          components << endpoint
          components << options.delete(:provider) if endpoint == :prices
          components << options.delete(:id)
        end.compact.join('/')

        uri = URI.parse url
        # uri.query = URI.encode_www_form(p: options.reverse_merge(lang: Sentimeta.lang).to_json)
        uri.query = URI.encode_www_form(p: options.merge(lang: Sentimeta.lang).to_json)
        uri
      end

      def send_request uri
        Sentimeta.logger.debug "  Sentimeta: #{ URI.unescape uri.to_s }"
        Observers.all.each { |o| o.notify "fetch", URI.unescape(uri.to_s) }
        begin
          JSON.parse(uri.open.read)
        rescue
          raise Sentimeta::Error::Unreachable
        end
      end

    end

  end
end
