module Sentimeta::Client::Auth
  extend self
  extend Sentimeta::RestClient

  self.namespace = 'crowd/auth'

  def user token
    get 'users/token', id: token
  end

  def signup attrs
    post :signup, attrs
  end

  def signin attrs
    post :signin, attrs
  end

  def reset_password_token login
    put 'users/create_reset_token', login: login
  end

  def reset_password params
    put 'users/reset_password', params
  end

  def oauth attrs
    post :oauth, attrs
  end

  def signout token
    delete 'users/token', id: token
  end
end
