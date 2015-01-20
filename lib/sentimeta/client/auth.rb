module Sentimeta::Client::Auth
  extend self
  extend Sentimeta::RestClient

  self.namespace = :auth

  def user token
    get :users, id: token
  end

  def signup attrs
    post :users, user: attrs
  end

  def signin attrs
    post :sessions, user: attrs
  end

  def reset_password_token email
    put 'passwords/create_token', email: email
  end

  def reset_password params
    put 'passwords/change', params
  end

  def oauth attrs
    post :oauth, identity: attrs
  end
end
