class Api::V1::SessionsController < Devise::SessionsController

  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token

  skip_before_action :authenticate_user!

  before_action :authenticate_api_v1_user!, :except => [:new, :create]
  before_action :ensure_params_exist, :except => [:new, :destroy, :create]
  #respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render :json=> {:auth_token=>resource.authentication_token, :email=>resource.email}, :status => :ok
      return
    end
    invalid_login_attempt
  end

  def destroy
    resource = User.find_by_authentication_token(params[:auth_token]||request.headers["X-AUTH-TOKEN"])
    resource.authentication_token = nil
    resource.save
    sign_out(resource_name)
    render :json => {}.to_json, :status => :ok
  end


  protected

  def ensure_params_exist
    return unless params[:email].blank? || params[:password].blank?
    render :json=>{:message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    render :json=> {:message=>"Error with your login or password"}, :status=>401
  end
end