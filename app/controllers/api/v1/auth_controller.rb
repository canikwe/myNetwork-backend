class Api::V1::AuthController < ApplicationController

  def create
    
    @user = User.find_by(username: login_params[:username])
    if @user && @user.authenticate(login_params[:password])

      token = encode({user_id: @user.id})
      render json: {
        message: 'Authenticated! You are lgged in',
        user: UserSerializer.new(@user),
        token: token,
        authenticated: true
        }, status: :accepted
    else
      render json: {
        message: 'Username and password do not match',
        authenticated: false
      }, status: :not_acceptable
    end
  end

  private
  def login_params
    params.require(:user).permit(:username, :password)
  end

end
