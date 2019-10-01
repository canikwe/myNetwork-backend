class Contact < ApplicationRecord
  # belongs_to :requestor, foreign_key: "requestor_id", class_name: "User"
  # belongs_to :requested, foreign_key: "requested_id", class_name: "User"
  belongs_to :user
  has_many :reminders, dependent: :destroy

  # accepts_nested_attributes_for :requested, allow_destroy: true


  def name
    "#{self.first_name} #{self.last_name}"
  end

  # def first_name
  #   self.requested.first_name
  # end

  # def last_name
  #   self.requested.last_name
  # end

  def friend_id
    self.user_id
  end

  # def avatar
  #   self.requested.avatar
  # end

  # def transfer_data
  #   first = self.requested.first_name
  #   last = self.requested.last_name
  #   self.update(first_name: first, last_name: last)
  # end

end
