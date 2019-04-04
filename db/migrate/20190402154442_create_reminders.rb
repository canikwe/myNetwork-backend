class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.string :msg
      t.date :date
      t.string :day, array: :true, default: ["1"]
      t.integer :contact_id

      t.timestamps
    end
  end
end
