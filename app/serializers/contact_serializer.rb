class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :friend_id, :kind, :details,
            :created_at, :updated_at
  # has_many :goals
  # has_many :reminder_goals

  # belongs_to :requestor, foreign_key: "requestor_id", class_name: "User"
  # belongs_to :requested, foreign_key: "requested_id", class_name: "User"

  def reminder_goals
    rem_goals = []
    self.object.reminders.each do |r|
      rem_goals.push(r.goals) if r.goals.length != 0
    end

    rem_goals.flatten
  end

end
