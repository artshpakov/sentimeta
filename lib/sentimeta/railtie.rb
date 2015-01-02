module Sentimeta
  class Railtie < Rails::Railtie

    config.sentimeta = ActiveSupport::OrderedOptions.new
    config.sentimeta.env = Sentimeta::DEFAULT_ENV
    config.sentimeta.observers = Sentimeta::Observers

    initializer "sentimeta.env" do |app|
      Sentimeta.env = app.config.sentimeta.env
    end

  end
end
