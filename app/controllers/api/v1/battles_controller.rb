module Api::V1
  class BattlesController < Api::ApplicationController

    def show
      if battle = Battle.find(params[:id])
        render json: battle, status: :ok
      else
        render json: {error: "Couldn't get battle."}, status: :unprocessable_entity
      end
    end

    def create
      @battle = Battle.new(battle_params)
      @battle.created_by = @user.id if @user
      if @battle.save
        render json: @battle, status: 201
      else
        render json: {error: "Couldn't create battle."}, status: :unprocessable_entity
      end
    end

    def update
      if request.method.to_s == 'PATCH'
        @battle = Battle.find(params[:battle][:id])
        FightBattleJob.perform_now @battle
        head :ok
      else
        render json: {error: "Needs to be a PATCH."}, status: :unprocessable_entity
      end
    end


    private

    def battle_params
      params.require(:battle).permit(:contest_id, :start_at, :won_at, :won_by, :created_by)
    end

  end
end