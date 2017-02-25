class Api::V1::RegistrationsController < Devise::RegistrationsController

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
#  respond_to :json

  skip_before_action :authenticate_user!
  skip_before_action :require_no_authentication, only: [:new, :create]

  skip_before_action :authenticate_scope!

  before_action :authenticate_api_v1_user!, :except => [:create]

  # because devise is nested in Api::V1, the resource name ends up being api_vi_user.
  # This overrides that so that strong params work, since they default  a :user key.
  def resource_name
   :user
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    # if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
        # PROBABLY want to return an auth token at this point.
        head :ok
      # else
      #   set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      #   expire_data_after_sign_in!
      #   # respond_with resource, location: after_inactive_sign_up_path_for(resource)
      #   head :ok
      # end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

end