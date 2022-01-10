class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :friend_id, :kind, :details, :created_at, :updated_at

  has_many :encounters

end
