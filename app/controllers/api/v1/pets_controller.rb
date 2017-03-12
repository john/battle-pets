module Api::V1
  class PetsController < Api::ApplicationController

    def index
      if pets = Pet.refresh_from_api
        render :json=> {pets: pets }, status: :ok
      else
        render :json => { :errors => "There was a problem getting pets." }, status: :unprocessable_entity
      end
    end

    def create
      wunder_api = Rails.application.secrets.pets_api_url
      pets_token = Rails.application.secrets.pets_token
      headers = {content_type: :json, accept: :json, "X-Pets-Token": pets_token}

      req_body = request.body.read
      resp = RestClient.post("#{wunder_api}/pets", req_body, headers )

      if resp.code == 201
        pet_hash = JSON.parse(resp.body)
        pet_hash['uuid'] = pet_hash['id']
        pet_hash.delete('id')
        pet = Pet.create(pet_hash)
        render :json=> pet, status: 201
      else
        render :json => { :errors => "There was a problem getting pets. Response from Wunder: #{resp.code}" }, status: :unprocessable_entity
      end
    end

    def pet_params
      params.require(:pet).permit(:uuid, :name, :strength, :intelligence, :speed, :integrity)
    end

  end
end