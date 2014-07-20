class Api::CartsController < ApiController
  def show
    @cart = current_user.cart
    if @cart.id.to_s == params[:id]
      respond_with @cart, root: 'cart'
    else
      render json: {}, status: 404
    end
  end
end