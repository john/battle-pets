class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :token_authenticatable

  validates :name, length: { maximum: 200 }, presence: true
  validates :email, length: { maximum: 200 }, presence: true
end
