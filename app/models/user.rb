class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # , :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable
  # devise :registerable, :database_authenticatable, :token_authenticatable

  # validates :name, length: { maximum: 200 }, presence: true
  # validates :email, length: { maximum: 200 }, presence: true
end


#   Parameters: {"utf8"=>"✓", "authenticity_token"=>"X9Xk9DxOqtS6R6aICNv3Xdn+VnkLM9FS6iO8GUe38iWt/PxPbQZe+qKrlV8++zdCKaKcA80/WY0PE8T1Dbc35Q==", "user"=>{"name"=>"John", "email"=>"john@foo.com", "phone_number"=>"2073328709", "description"=>"white", "city_state"=>"San Francisco,  CA", "city"=>"San Francisco", "state"=>"CA", "password"=>"[FILTERED]"}, "commit"=>"Volunteer to drive"}
# Geokit is using the domain: localhost
#
#