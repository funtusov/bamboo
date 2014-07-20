require 'spec_helper'

describe LineItem do
  let(:shop) { create :shop }
  let(:product) { create :product, shop: shop }
  let(:user) { create :user, shop: shop }
  let(:cart) { create :order, user: user }

  it 'creates a line item with product and quantity' do
    expect {
      LineItem.create()
    }.to change{LineItem.count}.by(1)
  end

end