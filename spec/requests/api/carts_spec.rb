require 'spec_helper'
require 'shared_contexts'

describe 'Carts API' do
  include_context 'multitenancy'
  include_context 'visitor created'

  it 'should not get anothers visitor cart' do
    get "/api/carts/#{another_user.cart.id}", format: :json
    expect(response.status).to eq(404)
  end

  it 'should get current visitor cart' do
    get "/api/carts/#{current_user.cart.id}", format: :json
    expect(response).to be_success
    expect(json['cart'].keys).to eq(%w(id line_item_ids))
  end
end