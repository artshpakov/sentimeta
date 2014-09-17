module Sentimeta

  require "sentimeta/version"
  require "sentimeta/client"
  require "sentimeta/model"
  require "sentimeta/error/unreachable"

  require 'logger'

  class << self
    attr_accessor :env, :sphere
    attr_writer :endpoint, :lang

    def endpoint
      @endpoint ||= begin
        config_path = File.join(File.dirname(File.expand_path(__FILE__)), '../config/endpoint.yml')
        config = YAML.load_file(config_path)[env.to_s].symbolize_keys
        config[:url]
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
