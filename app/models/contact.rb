class Contact < ApplicationRecord
  belongs_to :requestor, foreign_key: "requestor_id", class_name: "User"
  belongs_to :requested, foreign_key: "requested_id", class_name: "User"
  has_many :reminders, dependent: :destroy
  
  def name
    self.requested.name
  end

  def friend_id
    self.requested_id
  
  end

end