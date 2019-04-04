class Reminder < ApplicationRecord
  belongs_to :contact

  def friend_id
    self.contact.requested.id
  end

  def friend_name
    self.contact.requested.name
  end
end
