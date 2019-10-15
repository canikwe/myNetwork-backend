class Contact < ApplicationRecord
  # belongs_to :requestor, foreign_key: "requestor_id", class_name: "User"
  # belongs_to :requested, foreign_key: "requested_id", class_name: "User"
  belongs_to :user
  has_many :reminders, dependent: :destroy
  has_many :goals, as: :originator, dependent: :destroy
  has_many :reminder_goals, -> { where('goals.originator_type' => 'Reminder') }, through: :reminders, source: :goals

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

  def get_all_goals
    rem_goals = []

    # self.reminders.each do |r|
    #   rem_goals.push(r.goals) if r.goals.length != 0
    # end
    # byebug
    rem_goals.push(self.goals)
    rem_goals.push(self.reminder_goals).flatten
  end


end
