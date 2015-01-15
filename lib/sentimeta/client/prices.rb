module Sentimeta::Client::Prices
  extend self
  extend Sentimeta::RestClient

  def load options={}
    options[:id] = options.delete(:provider)
    get :prices, options
  end
end
