require 'spec_helper'

describe 'Products API' do
  let!(:shop) { create :shop }
  let!(:another_shop) { create :shop, domain: 'anothershop.com' }

  before :all do
    host! 'bookshop.com'
  end

  before :each do
    10.times do
      shop.products << FactoryGirl.create(:product)
    end

    5.times do
      another_shop.products << FactoryGirl.create(:product)
    end
  end

  it 'should get products' do
    get '/api/products', format: :json
    expect(response).to be_success
    expect(json['products'].length).to eq(10)
  end

  it 'should get a product' do
    get "/api/products/#{shop.products.first.id}", format: :json
    expect(response).to be_success
    expect(json['product'].keys).to eq(%w(id name description price)) 
  end

  it 'should not get other shop product' do
    get "/api/products/#{another_shop.products.first.id}", format: :json
    expect(response.status).to eq(404)
  end
end