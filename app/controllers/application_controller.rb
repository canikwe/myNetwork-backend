class ApplicationController < ActionController::API
  include Api::V1::Authenticatable
  
  before_action :authorized

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
  end

  private

  def current_user
    if decoded_token
      user_id = decoded_token['user_id']
      @user = User.find(user_id)
    end
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      decode(token)
    end
  end

  def auth_header
    request.headers[:Authorization]
  end
end
