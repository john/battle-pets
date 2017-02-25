module Api
  class ApplicationController < ActionController::Base

    before_action :get_auth_token
    before_action :authenticate_user_from_token!, :except => [:new, :create]


    #protect_from_forgery with: :exception, prepend: true
    protect_from_forgery with: :null_session

    rescue_from(ActionController::RoutingError, ActionController::UnknownController, ActiveRecord::RecordNotFound) do
      render json: {error: 'Not found'}, status: 404
    end


    private

    def authenticate_user_from_token!
      if @auth_token.blank?
        head :unauthorized
      else
        @user = nil
        User.find_each do |u|
          if Devise.secure_compare(u.authentication_token, @auth_token)
            @user = u
          end
        end
      end
    end

    def get_auth_token
      @auth_token = request.headers["X-AUTH-TOKEN"]
    end

  end
end
