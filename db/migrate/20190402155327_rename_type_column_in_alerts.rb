class RenameTypeColumnInAlerts < ActiveRecord::Migration[5.2]
  def change
    rename_column :alerts, :type, :name
  end
end
