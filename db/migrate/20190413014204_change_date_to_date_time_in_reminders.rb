class ChangeDateToDateTimeInReminders < ActiveRecord::Migration[5.2]
  def up
    change_column :reminders, :start_date, :datetime
    change_column :reminders, :end_date, :datetime
  end

  def down
    change_column :reminders, :start_date, :date
    change_column :reminders, :end_date, :date
  end
end
