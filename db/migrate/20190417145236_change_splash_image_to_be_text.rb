class ChangeSplashImageToBeText < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :splash_image, :text
  end
end
