module Sentimeta::Client::Data
  extend self
  extend Sentimeta::RestClient
  
  %i(criteria spheres objects catalog).each do |endpoint|
    define_method endpoint do |options={}|
      get(endpoint, options)[endpoint.to_s]
    end
  end

  def attributes options={}
    get(:attributes, options)['values']
  end
end
