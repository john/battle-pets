module Api::V1
  class ParticipantsController < Api::ApplicationController

    def index
      # TODO: implement
    end

    def show
      # TODO: implement
    end

    def create
      @participant = Participant.new(participant_params)
      @participant.created_by = @user.id
      if @participant.save
        # this should return the resource itself, probably.
        head :ok
      else
        render json: {error: "Couldn't create participant."}, status: :unprocessable_entity
      end
    end

    def participant_params
      params.require(:participant).permit(:battle_id, :pet_id, :created_by)
    end

  end
end