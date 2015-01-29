module Sentimeta::Client::Prices
  extend self
  extend Sentimeta::RestClient

  def sphere() :hotels end

  def load options={}
    options[:id] = options.delete(:provider)
    get :prices, options
  end
end
