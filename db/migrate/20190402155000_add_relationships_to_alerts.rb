class AddRelationshipsToAlerts < ActiveRecord::Migration[5.2]
  def change
    add_column :alerts, :relationship_id, :integer
  end
end
