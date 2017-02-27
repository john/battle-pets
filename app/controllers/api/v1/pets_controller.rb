module Api::V1
  class PetsController < Api::ApplicationController

    def index
      if pets = Pet.get_all_from_api
        render :json=> {pets: pets }, status: :ok
      else
        render :json => { :errors => "There was a problem getting pets." }, status: :unprocessable_entity
      end
    end

    def create
      if pet = Pet.create_from_api
        render :json=> pet, status: :ok
      else
        render :json => { :errors => "There was a problem getting pets." }, status: :unprocessable_entity
      end
    end

    def show
      # TODO: implement
    end

  end
end