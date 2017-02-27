class Battle < ApplicationRecord
  has_many :participants
  has_many :pets, through: :participants

  belongs_to :contest
end
