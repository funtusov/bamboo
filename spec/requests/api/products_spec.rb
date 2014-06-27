require 'spec_helper'

describe 'Products API' do
  let(:shop) { create :shop }

  before :each do
    10.times do
      shop.products << FactoryGirl.create(:product)
    end
  end

  it 'should get products' do
    get '/api/products', format: :json
    expect(response).to be_success
    expect(json['products'].length).to eq(10)
  end
end