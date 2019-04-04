class AlertSerializer < ActiveModel::Serializer
  attributes :id, :name, :frequency, :date, :day, :relationship_id, :friend_id, :friend_name, :created_at
end
