class AddSplashImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :splash_image, :string
  end
end
