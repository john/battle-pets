class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
  skip_before_action :require_no_authentication, only: [:new, :create]
  skip_before_action :authenticate_scope!

  before_action :authenticate_api_v1_user!, :except => [:create]

  # because devise is nested in Api::V1, the resource name ends up being api_vi_user.
  # This overrides that so that strong params work, since they default  a :user key.
  def resource_name
   :user
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.active_for_authentication?
      sign_up(resource_name, resource)
      head :ok
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

end