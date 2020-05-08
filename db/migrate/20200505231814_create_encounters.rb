class CreateEncounters < ActiveRecord::Migration[5.2]
  def change
    create_table :encounters do |t|
      t.integer :contact_id
      t.integer :reminder_id
      t.string :verb
      t.text :details
      t.integer :rating, :null => false, :default => 3
      t.date :date

      t.timestamps
    end
  end
end
