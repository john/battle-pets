class Contest < ApplicationRecord
  validates :name, length: { maximum: 200 }, presence: true

  def api_hash
    logger.debug "--> inside api_hash"
    {id: self.id, name: self.name, description: self.description,
      algorithm: self.algorithm, winning_characteristic: self.winning_characteristic }
  end

end
