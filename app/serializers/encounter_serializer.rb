class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :contact_id, :reminder_id, :verb, :details, :rating, :date
end
