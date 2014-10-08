module Sentimeta
  class Model

    def initialize params = {}
      (params || {}).each do |key, value|
        method = "#{key}="
        public_send(method, value) if respond_to?(method)
      end
    end


    def self.endpoint endpoint
      @endpoint = endpoint
    end


    protected

    def self.fetch options={}
      response = Sentimeta::Client.public_send @endpoint, options
      if response.kind_of? Array
        response.map { |entry| new entry }
      elsif response.kind_of? Hash
        new response
      end
    end

  end
end
