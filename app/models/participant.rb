class Participant < ApplicationRecord
  belongs_to :battle
  belongs_to :pet
end
