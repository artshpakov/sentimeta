module Sentimeta::Client::Prices
  extend self
  extend Sentimeta::RestClient

  def namespace
    :prices
  end

  def method_missing method, *args
    get method, *args
  end
end
