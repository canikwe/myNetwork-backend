class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :avatar, :bio, :email, :username, :splash_image, :photo
  include Rails.application.routes.url_helpers

  # has_many :contacts
  # has_many :reminders, through: :contacts

  def photo
    rails_blob_path(object.photo, only_path: true) if object.photo.attached?
  end

  # def friends
  #   friends = {}
  #   self.object.requests.each do |r|
  #     friends[r.requested.name] = r.alerts
  #   end
  #   friends
  # end

end
