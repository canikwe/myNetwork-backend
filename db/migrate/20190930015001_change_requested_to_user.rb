class ChangeRequestedToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :contacts, :requestor_id, :user_id
  end
end
