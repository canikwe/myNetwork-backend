class RemoveRequestedIdFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :requested_id, :integer
  end
end
