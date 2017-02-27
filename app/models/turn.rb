class Turn < ApplicationRecord
  belongs_to :battle
  belongs_to :participant
  belongs_to :move
  belongs_to :user
end
