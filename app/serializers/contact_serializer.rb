class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :friend_id
  
  belongs_to :requestor, foreign_key: "requestor_id", class_name: "User"
  belongs_to :requested, foreign_key: "requested_id", class_name: "User"


end
