class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :avatar
      t.text :bio
      t.string :default_type
      t.integer :default_frequency
      t.references :requester, index: true
      t.references :requested, index: true

      t.timestamps
    end
  end
end
