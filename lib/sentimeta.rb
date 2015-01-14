require "sentimeta/version"
require "sentimeta/client"
require "sentimeta/client/auth"
require "sentimeta/observers"
require "sentimeta/model"
require "sentimeta/logger"
require "sentimeta/error/unreachable"
require "sentimeta/error/record_not_found"

module Sentimeta
  DEFAULT_ENV = :production
end

require "sentimeta/railtie" if defined? Rails
require "sentimeta/mixins" unless defined? ActiveSupport

require "sentimeta/init"
