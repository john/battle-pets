class Move < ApplicationRecord
  validates :name, length: { maximum: 200 }, presence: true
end
