class Turn < ApplicationRecord
  belongs_to :battle
  belongs_to :participant
  belongs_to :user
  belongs_to :move
end
