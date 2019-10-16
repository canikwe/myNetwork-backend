class RemoveRequestedAndRequestorFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :requestor_id, :bigint
    remove_column :users, :requested_id, :bigint
  end
end
