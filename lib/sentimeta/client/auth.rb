module Sentimeta::Client::Auth
  extend self
  extend Sentimeta::RestClient

  def namespace
    :auth
  end

  def user token
    get :users, id: token
  end

  def signup attrs
    post :users, user: attrs
  end

  def signin attrs
    post :sessions, user: attrs
  end
end
