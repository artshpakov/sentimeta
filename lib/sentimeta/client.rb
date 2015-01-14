require 'json'
require "colorize"
require "rest_client"

require_relative 'client/basic'
require_relative 'client/prices'


module Sentimeta
  module Client

    class ApiResponse
      attr_accessor :status, :body

      def initialize response
        self.status = response.code
        self.body   = JSON.parse(response)
      end

      def ok?
        status < 300
      end

      delegate :[], to: :body
    end


    extend Basic
    extend Prices


    def fetch path, params={}
      method = params.delete(:method) || :get
      params = params.keep_if { |key, value| !!value }

      url = generate_uri path, params
      url = "#{ url }?p=#{ params.to_json }" if method.to_sym == :get && params.present?
      Sentimeta.logger.debug "  #{ 'Sentimeta:'.colorize :green } #{ method.upcase } #{ url } #{ params.to_json if params.present? && method.to_sym != :get }"
      Observers.each { |observer| observer.notify "fetch", "#{ method.upcase } #{ url } #{ params.to_json if params.present? }" }

      response = RestClient::Request.execute \
        method: method,
        url: URI::encode(url),
        payload: params,
        headers: { 'X-SERVER-ACCESS-TOKEN' => 'c916b1e13b30764b39d47475e1cef4ee' },
        accept: :json
      # rescue RestClient::Exception => e
      #   # raise Sentimeta::Error::Unreachable
      #   ApiResponse.new e.response
      ApiResponse.new response
    end

    def method_missing method, *args
      if %i(get post put patch delete options).include?(method)
        path, params = args
        fetch path, (params || {}).merge(method: method)
      else
        Sentimeta.logger.fatal "Unknown method #{ method }(#{ method.class.name })"
      end
    end


    private

    def generate_uri endpoint, options={}
      [].tap do |components|
        components << Sentimeta.endpoint
        components << (options.delete(:sphere) || Sentimeta.sphere) unless endpoint == :spheres
        components << namespace if respond_to?(:namespace)
        components << endpoint
        components << options.delete(:filter) if endpoint == :attributes  # TODO remove
        components << options.delete(:provider) if endpoint == :prices    # TODO remove
        components << options.delete(:id)
      end.compact.join('/')
    end
  end

end
