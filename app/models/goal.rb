class Goal < ApplicationRecord
  belongs_to :originator, polymorphic: true
end
