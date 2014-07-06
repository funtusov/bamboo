class Api::CartsController < ApiController
  def show
    # @cart = Cart.new#current_user.carts.first_or_create
    # respond_with @cart
    respond_with '{"cart": {"id": "1", "line_items": []}}'
  end
end