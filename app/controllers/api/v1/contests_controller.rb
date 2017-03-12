module Api::V1
  class ContestsController < Api::ApplicationController

    def index
      if contests = Contest.all
        payload = contests.map { |contest| contest.api_hash }
        render json: {contests: payload}, status: :ok
      else
        render json: { errors: "There was a problem getting contests." }, status: :unprocessable_entity
      end
    end

    def create
      @contest = Contest.new(contest_params)
      @contest.created_by = @user.id if @user
      if @contest.save
        render json: @contest, status: 201
      else
        render json: {error: "Couldn't create contest."}, status: :unprocessable_entity
      end
    end

    private

    def contest_params
      params.require(:contest).permit(:name, :description, :algorithm, :start_at, :won_at, :created_by, :won_by)
    end

  end
end