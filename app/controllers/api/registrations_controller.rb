class Api::RegistrationsController < Devise::RegistrationsController#ApiController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      sign_up(resource_name, resource)
      render json: resource
    else
      render json: {errors: resource.errors}, status: 422
    end
  end

private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end