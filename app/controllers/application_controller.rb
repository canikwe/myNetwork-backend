class ApplicationController < ActionController::API
  before_action :authorized

  def auth_header
    request.headers[:Authorization]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      decode(token)
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token['user_id']
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
  end

  private
  def secret_key
    Rails.application.credentials.JWT_secret
  end

  def encode(payload)
    JWT.encode(payload, secret_key, 'HS256')
  end

  def decode(token)
    JWT.decode(token, secret_key, true, {algorithm: 'HS256'})[0]
  end

end
