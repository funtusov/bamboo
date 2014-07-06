require 'spec_helper'
require 'shared_contexts'

describe 'Carts API' do
  include_context "multitenancy"

  let(:cart) { create :cart }

  it 'should get current visitor cart' do
    get "/api/carts/#{cart.id}", format: :json
    expect(response).to be_success
    expect(json['cart'].keys).to eq(%w(id line_items))
  end

  it 'should create line items'
  it 'should modift line items'
  it 'should remove line items'
end