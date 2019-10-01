class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:show, :update]

  def profile
    token = request.headers['Authentication'].split(' ')[1]
    payload = decode(token)

    user = User.find(payload['user_id'])
    if user
      render json: { user: UserSerializer.new(user), reminders: user.reminders.map { |r| ReminderSerializer.new(r) }, contacts: user.contacts.map { |c| ContactSerializer.new(c) } }, status: :accepted
    end
  end

  def index
    render json: User.all, status: :accepted
  end

  def show
    render json: @user, status: :accepted
  end

  def update
    @user.update(user_params)
    render json: { message: 'Your account has been updated!', user: UserSerializer.new(@user) }, status: :accepted
  end

  def create
    # if !user_params[:contact_attributes].nil?
    #   @user = User.create(first_name: user_params[:user_info][:first_name], last_name: user_params[:user_info][:last_name], avatar: user_params[:user_info][:avatar], password: 'guest_user_account')
    #
    #   contact = Contact.create(requestor_id: user_params[:contact_attributes][:requestor_id], kind: user_params[:contact_attributes][:kind], details: user_params[:contact_attributes][:details], requested_id: @user.id)
    #
    #   render json: contact, status: :accepted
    # else
    byebug
    user = User.new(user_params)
    if user.save
      token = encode({user_id: user.id})
      render json: { message: 'Thanks for signing up! Allow us to log you in 😬',
                    user: UserSerializer.new(user),
                    reminders: user.reminders.map { |r| ReminderSerializer.new(r) },
                    contacts: user.contacts.map { |c| ContactSerializer.new(c) },
                    token: token,
                    authenticated: true}, status: :accepted
    else
      render json: { message: @user.errors.full_messages, status: :not_acceptable }
    end
    # end
  end

  private
  def get_user

    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:id, :first_name, :last_name, :username, :email, :avatar, :bio, :requestor_id, :requested_id, :password, :password_confirm, :splash_image, :photo)
  end

  def contact_params
    params.permit(:id, :requestor_id, :kind, :details)

  end
end
