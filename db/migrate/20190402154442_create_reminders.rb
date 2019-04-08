class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.string :msg
      t.date :start_date
      t.integer :interval
      t.string :period
      t.boolean :snoozed, default: false
      t.date :current
      t.integer :contact_id

      t.timestamps
    end
  end
end
