class User < ApplicationRecord
  has_many :requests, foreign_key: :requester_id, class_name: "Relationship"
  has_many :requested, foreign_key: :requested_id, class_name: "Relationship"
end
