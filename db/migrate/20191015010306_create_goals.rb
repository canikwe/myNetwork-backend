class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.boolean :complete, :default => false
      t.datetime :comeplete_date
      t.references :originator, polymorphic: true

      t.timestamps
    end
  end
end
