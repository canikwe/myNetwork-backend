class AddPriorityToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :priority, :string
  end
end
