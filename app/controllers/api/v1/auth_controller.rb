class Api::V1::AuthController < ApplicationController

  def create
    
    @user = User.find_by(username: login_params[:username])
    if @user && @user.authenticate(login_params[:password])
      render json: {
        message: 'Authenticated! You are lgged in',
        user: UserSerializer.new(@user),
        status: :success
        }, status: :accepted
    else
      render json: {
        message: 'Username and password do not match',
        status: :client_error
      }, status: :not_acceptable
    end
  end

  private
  def login_params
    params.require(:user).permit(:username, :password)
  end

end
