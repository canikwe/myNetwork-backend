class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:show, :update]


  def profile
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)

    @user = User.find(payload['user_id'])
    if @user
      render json: @user, status: :accepted
    end
  end

  def index
    render json: User.all, status: :accepted
  end

  def show
    render json: @user, status: :accepted
  end

  def update
    @user.update(user_params[:user_info])
    render json: { message: 'Your account has been updated!', user: @user }, status: :accepted
  end

  def create
    if !user_params[:contact_attributes].nil?
      @user = User.create(first_name: user_params[:user_info][:first_name], last_name: user_params[:user_info][:last_name], avatar: user_params[:user_info][:avatar], password: 'guest_user_account')
      
      contact = Contact.create(requestor_id: user_params[:contact_attributes][:requestor_id], kind: user_params[:contact_attributes][:kind], details: user_params[:contact_attributes][:details], requested_id: @user.id)
      
      render json: contact, status: :accepted
    else
      @user = User.new(user_params[:user_info])
      if @user.save
        token = encode({user_id: @user.id})
        render json: { message: 'Authenticated! You are lgged in',
                      user: UserSerializer.new(@user),
                      token: token,
                      authenticated: true}, status: :accepted
      else
        render json: { message: @user.errors.full_messages, status: :not_acceptable }
      end
    end
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(user_info: [:id, :first_name, :last_name, :username, :email, :avatar, :bio, :requestor_id, :requested_id, :password, :password_confirm], contact_attributes:[:id, :requestor_id, :kind, :details])
  end
end
