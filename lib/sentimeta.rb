module Sentimeta

  require "sentimeta/version"
  require "sentimeta/client"
  require "sentimeta/model"
  require "sentimeta/error/unreachable"

  class << self
    attr_accessor :env, :lang, :sphere
    attr_writer :endpoint

    def endpoint
      @endpoint ||= begin
        config_path = File.join(File.dirname(File.expand_path(__FILE__)), '../config/endpoint.yml')
        config = YAML.load_file(config_path)[env.to_s].symbolize_keys
        config[:url]
      end
    end
  end

  self.env = :production

end
