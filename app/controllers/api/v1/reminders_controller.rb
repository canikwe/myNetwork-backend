class Api::V1::RemindersController < ApplicationController
  before_action :get_reminder, only: [:update, :destroy]

  def create
    reminder = Reminder.create(reminder_params)
    render json: ReminderSerializer.new(reminder), status: :accepted
  end
  
  def update
    # @reminder.advance_reminder
    @reminder.update(reminder_params)
    render json: @reminder, status: :accepted
  end

  def destroy
    reminder = @reminder
    @reminder.destroy
    render json: reminder, status: :accepted
  end

  private
  def reminder_params
    params.require(:reminder).permit(:id, :msg, :start_date, :interval, :period, :snoozed, :current, :contact_id, :recurring, :end_date, :priority)
  end

  def get_reminder
    @reminder = Reminder.find(params[:id])
  end

end
