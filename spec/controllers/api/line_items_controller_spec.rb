require 'spec_helper'
require 'shared_contexts'

describe Api::LineItemsController do
  include_context 'multitenancy'
  include_context 'visitor created'

  it 'should create a correct line item' do
    product = shop.products.first
    expect {
      post :create, line_item: {product_id: product.id.to_s, quantity: 1}, format: :json
    }.to change{current_user.cart.line_items.where(product: product, quantity: 1).count}.by(1)
  end

  context 'when a line item exists' do
    let!(:line_item) { create :line_item, product: shop.products.first, order: cart }

    it 'should update a line item' do 
      expect {
        patch :update, id: line_item.id, line_item: {quantity: 2}, format: :json      
      }.to change{line_item.reload.quantity}.to(2)
    end

    it 'should destroy a line item' do
      expect {
        delete :destroy, id: line_item.id, format: :json
      }.to change{current_user.reload.cart.line_items.count}.by(-1)
    end
  end
end