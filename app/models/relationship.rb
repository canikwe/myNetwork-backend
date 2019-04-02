class Relationship < ApplicationRecord
  belongs_to :requests, foreign_key: "requester_id", class_name: "User"
  belongs_to :requested, foreign_key: "requested_id", class_name: "User"
  has_many :alerts
end