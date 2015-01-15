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

  ##
  # Usage:
  #   search text: 'pitt' [, where: 'actors' ]
  def search options={}
    if options.has_key? :where
      search_local(options[:where], options[:text])[options[:where]]
    else
      search_global options[:text]
    end
  end

  private

  def search_global(text)
    get :search, { text: text }
  end

  def search_local(where, text)
    get :search, { where: where, text: text }
  end

end
