require 'json'
require "colorize"
require "rest_client"

module Sentimeta
  module RestClient
    require "sentimeta/error/unreachable"
    # require "sentimeta/error/record_not_found"

    attr_accessor :namespace
    

    class ApiResponse
      attr_accessor :status, :body

      def initialize response
        self.status = response.code
        self.body   = JSON.parse(response) rescue nil
      end

      def ok?
        status < 300
      end

      def [] key
        body[key] if body.respond_to?(:[])
      end
    end


    def fetch path, params={}
      method = params.delete(:method) || :get
      params = params.keep_if { |key, value| !!value }

      url = generate_uri path, params
      url = "#{ url }?p=#{ params.to_json }" if method.to_sym == :get && params.present?
      Sentimeta.logger.debug "  #{ 'Sentimeta:'.colorize :green } #{ method.upcase } #{ url } #{ params.to_json if params.present? && method.to_sym != :get }"
      Observers.each { |observer| observer.notify "fetch", "#{ method.upcase } #{ url } #{ params.to_json if params.present? }" }

      response = begin
        ::RestClient::Request.execute \
          method: method,
          url: URI::encode(url),
          payload: params,
          headers: { 'X-SERVER-ACCESS-TOKEN' => 'c916b1e13b30764b39d47475e1cef4ee' }, # TODO define a property
          accept: :json
      rescue ::RestClient::Exception => e
        Sentimeta.logger.error "  #{ 'Sentimeta:'.colorize :red } #{ e.message } / #{ e.response }"
        return ApiResponse.new e.response
      rescue Exception => e
        raise Sentimeta::Error::Unreachable.new e.message
      end
      ApiResponse.new response
    end

    def method_missing method, *args
      if %i(get post put patch delete options).include?(method)
        path, params = args
        fetch path, (params || {}).merge(method: method)
      else
        Sentimeta.logger.fatal "Unknown method #{ method }(#{ method.class.name })" # TODO remove
      end
    end

    def generate_uri endpoint, options={}
      [].tap do |components|
        components << Sentimeta.endpoint
        components << (options.delete(:sphere) || Sentimeta.sphere) unless endpoint == :spheres
        components << namespace unless namespace.nil?
        components << endpoint
        components << options.delete(:filter) if endpoint == :attributes  # TODO remove
        components << options.delete(:provider) if endpoint == :prices    # TODO remove
        components << options.delete(:id)
      end.compact.join('/')
    end
  end

end
