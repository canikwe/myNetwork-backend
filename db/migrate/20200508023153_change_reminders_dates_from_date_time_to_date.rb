class ChangeRemindersDatesFromDateTimeToDate < ActiveRecord::Migration[5.2]
  def change
    change_column :reminders, :start_date, :date
    change_column :reminders, :end_date, :date
  end
end
