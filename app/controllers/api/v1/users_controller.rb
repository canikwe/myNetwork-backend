class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:show, :update]

  def index
    render json: User.all, status: :accepted
  end

  def show
    render json: @user, status: :accepted
  end

  def update

    @user.update(user_params)
    render json: @user, status: :accepted
  end

  def create
    if user_params.has_key?(:requestor_id)
      @user = User.create(first_name: user_params[:first_name], last_name: user_params[:last_name], password: 'guest_user_account')
      
      contact = Contact.create(requestor_id: user_params[:requestor_id], requested_id: @user.id)
      
      render json: contact, status: :accepted
    else
      @user = User.new(user_params)
      if @user.save
      render json: @user, status: :accepted
      else
        render json: { error: @user.errors.full_messages, status: :not_acceptable }
      end
    end
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :username, :email, :avatar, :bio, :requestor_id, :requested_id)
  end
end
