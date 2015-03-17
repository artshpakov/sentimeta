module Sentimeta
  class Railtie < Rails::Railtie

    config.sentimeta              = ActiveSupport::OrderedOptions.new
    config.sentimeta.env          = Sentimeta::DEFAULT_ENV
    config.sentimeta.observers    = Sentimeta::Observers

    initializer "sentimeta.env" do |app|
      Sentimeta.env           = app.config.sentimeta.env
      Sentimeta.server_token  = app.config.sentimeta.server_token
    end

  end
end
