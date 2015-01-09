require 'json'


module Sentimeta
  module Client

    class << self
      %i(criteria spheres objects catalog).each do |endpoint|
        define_method endpoint do |options={}|
          Sentimeta::Client.fetch(endpoint, options)[endpoint.to_s]
        end
      end

      def attributes options={}
        fetch(:attributes, options)['values']
      end

      def prices options={}
        get :prices, options
      end

      def get endpoint, options={}
        options = options.keep_if { |key, value| !!value }
        begin
          uri = generate_uri endpoint, options
          Sentimeta.logger.debug "  #{ 'Sentimeta:'.green } #{ uri }"
          Observers.each { |observer| observer.notify "fetch", URI.unescape(uri.to_s) }
          JSON.parse RestClient.get URI.escape(uri), accept: :json
        rescue
          raise Sentimeta::Error::Unreachable
        end
      end
      alias_method :fetch, :get

      def post endpoint, options={}
        # response = RestClient.post url, options, 'X-SERVER-ACCESS-TOKEN' => Sentimeta.token
      end


      private

      def generate_uri endpoint, options={}
        [].tap do |components|
          components << Sentimeta.endpoint
          components << (options.delete(:sphere) || Sentimeta.sphere) unless endpoint == :spheres
          components << endpoint
          components << options.delete(:filter) if endpoint == :attributes
          components << options.delete(:provider) if endpoint == :prices
          components << options.delete(:id)
        end.compact.join('/') + ("?p=#{ options.to_json }" if options.any?)
      end
    end

  end
end
