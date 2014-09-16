module Sentimeta
  class Model

    def self.endpoint endpoint
      @endpoint = endpoint
    end


    protected

    def self.fetch options={}
      Sentimeta::Client.fetch @endpoint, options
    end

  end
end
