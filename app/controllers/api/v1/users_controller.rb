class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:show, :update]
  skip_before_action :authorized, only: [:create]

  def profile
    render json: {
      user: UserSerializer.new(@user),
      reminders: @user.reminders.map { |r| ReminderSerializer.new(r) },
      contacts: @user.contacts.map { |c| ContactSerializer.new(c) },
      goals: @user.contacts.map { |c| c.get_all_goals }.flatten
    }, status: :accepted
end

  def index
    render json: User.all, status: :accepted
  end

  def show
    render json: @user, status: :accepted
  end

  def update
    @user.update(user_params)
    render json: {
      message: 'Your account has been updated!',
      user: UserSerializer.new(@user)
    }, status: :accepted
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        message: 'Thanks for signing up! Allow us to log you in 😬',
        user: UserSerializer.new(user),
        reminders: user.reminders.map { |r| ReminderSerializer.new(r) },
        contacts: user.contacts.map { |c| ContactSerializer.new(c) },
        goals: user.contacts.map { |c| c.get_all_goals }.flatten,
        token: encode({user_id: user.id}),
        authenticated: true
      }, status: :accepted
    else
      render json: {
        message: user.errors.full_messages
      }, status: :not_acceptable
    end
  end

  private
  # def get_user
  #   @user = User.find(params[:id])
  # end

  def user_params
    params.permit(:id, :first_name, :last_name, :username, :email, :avatar, :bio, :requestor_id, :requested_id, :password, :password_confirm, :splash_image, :photo)
  end

  def contact_params
    params.permit(:id, :requestor_id, :kind, :details)
  end
end
