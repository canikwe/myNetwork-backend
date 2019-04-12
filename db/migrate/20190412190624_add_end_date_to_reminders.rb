class AddEndDateToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :end_date, :date
  end
end
