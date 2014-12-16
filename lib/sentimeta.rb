module Sentimeta

  require "sentimeta/version"
  require "sentimeta/client"
  require "sentimeta/observers"
  require "sentimeta/model"
  require "sentimeta/logger"
  require "sentimeta/error/unreachable"

  require 'logger'
  require 'yaml'

  class << self
    attr_accessor :env, :sphere
    attr_writer :endpoint, :lang

    def endpoint
      @endpoint ||= begin
        config_path = File.join(File.dirname(File.expand_path(__FILE__)), '../config/endpoint.yml')
        config = YAML.load_file(config_path)[env.to_s]
        config['url']
      end
    end

    def lang
      if defined?(::I18n) and ::I18n.respond_to?(:locale)
        self.lang = I18n.locale
      end
      @lang || :en
    end

    def logger
      @logger ||= Logger.new STDOUT
    end
  end

  self.env = :production

end
