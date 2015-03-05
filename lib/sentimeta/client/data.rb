module Sentimeta::Client::Data
  extend self
  extend Sentimeta::RestClient

  def sphere() Sentimeta.sphere end

  
  %i(criteria spheres objects catalog).each do |endpoint|
    define_method endpoint do |options={}|
      get(endpoint, options)[endpoint.to_s]
    end
  end

  def attributes options={}
    get(:attributes, options)['values']
  end

  def medal id, options
    get(:objects, options.merge(id: "#{ id }/medal"))['medal']
  end

  ##
  # Usage:
  #   search text: 'pitt' [, where: 'actors' ]
  def search options={}
    result = get :search, options
    if options.has_key? :where
      result[options[:where]]
    else
      result
    end
  end

end
