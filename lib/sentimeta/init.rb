require 'yaml'


module Sentimeta
  class << self

    attr_accessor :env, :server_token, :sphere
    attr_writer :endpoint, :lang, :logger

    def endpoint
      @endpoint ||= ENV['SENTIMETA_API_URL'] || begin
        config_path = File.join(File.dirname(File.expand_path(__FILE__)), '../../config/endpoint.yml')
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

    def init options
      options.each do |option, value|
        public_send("#{ option }=", value) if respond_to?("#{ option }=")
      end
    end

    def logger
      @logger ||= Logger.new STDOUT
    end
  end

  self.env = DEFAULT_ENV

end
