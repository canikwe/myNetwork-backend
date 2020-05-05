class Contact < ApplicationRecord
  belongs_to :user
  has_many :reminders, dependent: :destroy

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def friend_id
    self.user_id
  end

end
