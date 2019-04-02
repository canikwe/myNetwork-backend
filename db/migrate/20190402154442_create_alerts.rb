class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.string :name
      t.integer :frequency
      t.date :date
      t.string :day, array: :true, default: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
      t.integer :relationship_id

      t.timestamps
    end
  end
end
