class Api::V1::RemindersController < ApplicationController
  def create
    reminder = Reminder.create(reminder_params)
    render json: reminder, status: :accepted
  end

  private
  def reminder_params
    params.require(:reminder).permit(:id, :msg, :date, :contact_id, :day => [])
  end

end
