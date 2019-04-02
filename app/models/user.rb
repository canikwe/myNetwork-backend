class User < ApplicationRecord
  has_many :friender_friends, foreign_key: :friendee_id, class_name: "Relationship"
  has_many :frienders, through: :friender_friends, source: :friender

  has_many :friendee_friends, foreign_key: :friender_id, class_name: "Relationship"
  has_many :friendees, through: :friendee_friends, source: :friendee
end
