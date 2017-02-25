class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :name) }
    # devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :name) }
    # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :name) }
    #
    logger.debug "---------------> IN EHRE"
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :description, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :description, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :description, :email])
  end

end
