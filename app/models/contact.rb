class Contact < ApplicationRecord
  belongs_to :user
  has_many :reminders, dependent: :destroy
  has_many :goals, as: :originator, dependent: :destroy
  has_many :reminder_goals, -> { where('goals.originator_type' => 'Reminder') }, through: :reminders, source: :goals

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def friend_id
    self.user_id
  end

  def get_all_goals
    self.goals + self.reminder_goals
  end

end
