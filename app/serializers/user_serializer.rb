class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :avatar, :bio, :email, :username, :splash_image, :photo
  include Rails.application.routes.url_helpers

  def photo
    rails_blob_path(object.photo, only_path: true) if object.photo.attached?
  end

end
