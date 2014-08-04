class Api::LineItemsController < ApiController
  def show
    @line_item = current_user.cart.line_items.find params[:id]
    respond_with @line_item
  end

  def create
    @line_item = current_user.cart.line_items.build(line_item_params)
    if @line_item.save
      render json: @line_item, status: 201
    else
      render json: {errors: @line_item.errors.full_messages}, status: 422
    end
  end

  def update
    @line_item = current_user.cart.line_items.find params[:id]
    if @line_item.update_attributes(line_item_params)
      render json: @line_item, status: 200
    else
      render json: {errors: @line_item.errors.full_messages}, status: 422
    end
  end

  def destroy
    @line_item = current_user.cart.line_items.find params[:id]
    @line_item.destroy
    render json: {}, status: 200
  end

  private

  def line_item_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end