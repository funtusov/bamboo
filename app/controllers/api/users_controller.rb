class Api::UsersController < ApiController
  def show
    if current_user.id.to_s == params[:id]
      render json: current_user, status: 200
    else
      render json: {}, status: 401
    end
  end
end