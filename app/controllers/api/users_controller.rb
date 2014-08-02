class Api::UsersController < ApiController
  include Devise::Controllers::Helpers 

  before_action :verify_user

  def show
    render json: current_user, status: :created
  end

  def update
    successfuly_updated = if current_user.user?
      if needs_password?
        current_user.update_with_password(user_params)
      else
        current_user.update_without_password(user_params)
      end
    else
      if current_user.update_attributes(user_params)
        sign_in(current_user, bypass: true) if current_user.user?
        true
      else
        current_user.clean_up_passwords
        false
      end
    end

    if successfuly_updated
      render json: current_user, status: :created
    else
      render json: {errors: current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def needs_password?
    params[:user][:password].present?
  end

  def verify_user
    render json: {}, status: 401 and return false unless current_user.id.to_s == params[:id]
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :current_password)
  end
end