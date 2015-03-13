module Sentimeta::Client::UserReviews
  extend self
  extend Sentimeta::RestClient

  self.namespace = 'crowd/data/object_reviews'

  def find options
    id = options.delete(:id)
    criterion = options.delete(:criterion)
    path = "#{Sentimeta.sphere}/#{id}"
    path += "/#{criterion}" if criterion
    fetch path, options
  end

  def create options
    id = options.delete(:id)
    post "#{Sentimeta.sphere}/#{id}", options
  end


end
