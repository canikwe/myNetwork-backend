class Encounter < ApplicationRecord
  belongs_to :contact
  belongs_to :reminder, optional: true
end
