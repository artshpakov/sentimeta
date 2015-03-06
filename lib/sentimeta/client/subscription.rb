module Sentimeta::Client::Subscription
  extend self
  extend Sentimeta::RestClient

  self.namespace = 'crowd'

  def subscribe email
    post :subscriptions, email: email
  end

  def unsubscribe email
    delete :subscriptions, email: email
  end
end
