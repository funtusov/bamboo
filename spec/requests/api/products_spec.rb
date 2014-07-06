require 'spec_helper'
require 'shared_contexts'

describe 'Products API' do
  include_context "multitenancy"

  it 'should get products' do
    get '/api/products', format: :json
    expect(response).to be_success
    expect(json['products'].length).to eq(10)
  end

  it 'should get a product' do
    get "/api/products/#{shop.products.first.id}", format: :json
    expect(response).to be_success
    expect(json['product'].keys).to eq(%w(id name description price img color fabric made_in)) 
  end

  it 'should not get other shop product' do
    get "/api/products/#{another_shop.products.first.id}", format: :json
    expect(response.status).to eq(404)
    expect(response.body).to eq('{"error": "not_found"}')
  end
end