class AddPriorityIntegersToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :priority, :integer
  end
end
