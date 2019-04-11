class Contact < ApplicationRecord
  belongs_to :requestor, foreign_key: "requestor_id", class_name: "User"
  belongs_to :requested, foreign_key: "requested_id", class_name: "User"
  has_many :reminders, dependent: :destroy

  accepts_nested_attributes_for :requested, allow_destroy: true

  
  def name
    self.requested.name
  end

  def first_name
    self.requested.first_name
  end

  def last_name
    self.requested.last_name
  end

  def friend_id
    self.requested_id
  
  end

end