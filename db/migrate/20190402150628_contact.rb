class Contact < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :requestor_id
      t.integer :requested_id
      
      t.timestamps
    end
  end
end
