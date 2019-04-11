class AddRecurringToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :recurring, :boolean, default: true
  end
end
