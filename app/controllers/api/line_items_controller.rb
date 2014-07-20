class Api::LineItemsController < ApiController
  def create
    current_user.cart.line_items.create(line_item_params)
    render json: {}
  end

  private

  def line_item_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end