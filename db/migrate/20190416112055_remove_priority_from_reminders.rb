class RemovePriorityFromReminders < ActiveRecord::Migration[5.2]
  def change
    remove_column :reminders, :priority, :string
  end
end
