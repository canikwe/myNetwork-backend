class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  has_many :contacts, foreign_key: :requestor_id, class_name: "Contact", dependent: :destroy
  has_many :requested_contact, foreign_key: :requested_id, class_name: "Contact" , dependent: :destroy
  # has_many :friends, foreign_key: :requester_id, class_name: "Relationship", dependent: :destroy
    # has_many :requested, foreign_key: :requested_id, class_name: "Relationship" , dependent: :destroy

  has_many :reminders, through: :contacts

  has_secure_password

  def name
    "#{self.first_name} #{self.last_name}"
  end

  # def friends
  #   self.requests.map do |f|
  #     f.requested
  #   end
  # end
end
