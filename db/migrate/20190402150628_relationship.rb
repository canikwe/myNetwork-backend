class Relationship < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :requester_id
      t.integer :requested_id
      
      t.timestamps
    end
  end
end
