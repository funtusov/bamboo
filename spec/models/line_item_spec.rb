require 'spec_helper'

describe LineItem do
  let(:shop) { create :shop }
  let(:product) { create :product, shop: shop }
  let(:user) { create :user, shop: shop }
  let(:cart) { create :order, user: user }
  let(:line_item) { create :line_item, product: product, order: cart }

  it 'should be valid' do
    expect(line_item).to be_valid
  end

  it 'quantity should be present' do
    line_item.update_attributes(quantity: nil)
    expect(line_item).not_to be_valid
  end

  it 'quantity should be > 0' do
    line_item.update_attributes(quantity: 0)
    expect(line_item).not_to be_valid
  end
end