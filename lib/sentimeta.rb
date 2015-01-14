require "sentimeta/version"

module Sentimeta
  DEFAULT_ENV = :production
  module Client end
end

require "sentimeta/rest_client"
require "sentimeta/client/data"
require "sentimeta/client/prices"
require "sentimeta/client/auth"
require "sentimeta/client"
require "sentimeta/observers"
require "sentimeta/model"
require "sentimeta/logger"
require "sentimeta/railtie" if defined? Rails
require "sentimeta/init"
