class ReminderSerializer < ActiveModel::Serializer
  attributes :id, :msg, :start_date, :interval, :period, :snoozed, :current, :contact_id, :match
end
