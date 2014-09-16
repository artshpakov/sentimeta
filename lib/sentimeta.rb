module Sentimeta

  API_ENDPOINT = 'http://148.251.160.76/api/v1'

  require "sentimeta/version"
  require "sentimeta/client"
  require "sentimeta/model"
  require "sentimeta/error/unreachable"

  class << self
    def lang= lang
      @lang = lang
    end

    def lang
      @lang
    end

    def sphere= sphere
      @sphere = sphere
    end

    def sphere
      @sphere
    end
  end

end
