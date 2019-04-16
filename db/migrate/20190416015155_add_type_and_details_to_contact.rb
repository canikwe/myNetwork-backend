class AddTypeAndDetailsToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :type, :string
    add_column :contacts, :details, :text
  end
end
