module Api
  class ApplicationController < ActionController::Base
    before_action :authenticate_user_from_token!
    before_action :only_allow_json

    protect_from_forgery with: :null_session

    rescue_from(ActionController::RoutingError, ActionController::UnknownController, ActiveRecord::RecordNotFound) do
      render json: {error: 'Not found'}, status: 404
    end


    private

    def authenticate_user_from_token!
      auth_token = request.headers["X-AUTH-TOKEN"]
      if u = User.find_by_authentication_token(auth_token)
        if Devise.secure_compare(u.authentication_token, auth_token)
          @user = u
        end
      end
      head :unauthorized if @user.blank?
    end

    def only_allow_json
      head 422 and return unless request.headers["ACCEPT"].present? && request.headers["ACCEPT"] == 'application/json'
    end

  end
end
