class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def index
    render json: User.all, status: :accepted
  end

  def show
    render json: @user, status: :accepted
  end

  private
  def get_user
    @user = User.find(params[:id])
  end
end
