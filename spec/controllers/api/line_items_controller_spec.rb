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

  # it 'should not create a '
end