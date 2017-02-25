class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # , :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable
  # devise :registerable, :database_authenticatable, :token_authenticatable

  validates :name, length: { maximum: 200 }, presence: true
  validates :email, length: { maximum: 200 }, presence: true
end
