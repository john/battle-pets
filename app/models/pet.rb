class Pet < ApplicationRecord
  has_many :participants
  has_many :contests, through: :participants

  validates :name, length: { maximum: 200 }
  validates :uuid, presence: true

  TOKEN = Rails.application.secrets.pets_token
  HEADERS = {content_type: :json, accept: :json, "X-Pets-Token": Pet::TOKEN}


  def self.get_json_from_api
    pets_url = "https://wunder-pet-api-staging.herokuapp.com/pets"
    resp = RestClient.get(pets_url, Pet::HEADERS)

    if resp.code == 200
      resp.body
    else
      raise "Error talking to pets API."
    end

  end

  def self.refresh_from_api
    if pet_json = Pet.get_json_from_api
      JSON.parse(pet_json).each do |pet_hash|
        pet_hash['uuid'] = pet_hash['id']
        pet_hash.delete('id')
        pet = Pet.find_or_create_by(uuid: pet_hash["uuid"])
        pet.update(pet_hash)
      end
    else
      raise "Error refreshing from API."
    end
  end

  # # format: {'name': 'Leonard', 'strength': 12, 'intelligence': 22, 'speed': 21, 'integrity': 66}
  # def self.create_from_api(name:, strength:, intelligence:, speed:, integrity:)
  #
  # end

  # def self.create_from_api
  #   # TODO: replace hardcoded url when pets API is fixed
  #   pet_url = "https://wunder-pet-api-staging.herokuapp.com/pets/1d4d557b-2470-40cb-b2e4-1bc138914464"
  #   resp = RestClient.get(pet_url, Pet::HEADERS)
  #
  #   if resp.code == 200
  #     resp_hash = JSON.parse(resp.body)
  #
  #     resp_hash['uuid'] = resp_hash['id']
  #     resp_hash.delete('id')
  #
  #     pet = Pet.find_or_create_by(uuid: resp_hash["uuid"])
  #     pet.update(resp_hash)
  #     pet
  #   else
  #     nil
  #   end
  # end

end
