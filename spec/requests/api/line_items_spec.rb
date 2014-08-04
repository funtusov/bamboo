require 'spec_helper'
require 'shared_contexts'

describe 'Line Items API' do
  include_context 'multitenancy'
  include_context 'visitor created'

  it 'should return the line item on successful create' do
    post "/api/line_items", line_item: {product_id: shop.products.first.id}, format: :json
    expect(response.status).to eq(201)
    expect(json['line_item']).to be_present
  end

  it 'should return error on invalid create' do
    post "/api/line_items", line_item: {product_id: shop.products.first.id, quantity: -1}, format: :json
    expect(response.status).to eq(422)
    expect(json['errors']).to be_present
  end

  context 'when a line item exists' do
    let!(:line_item) { create :line_item, product: shop.products.first, order: cart }

    it 'should get a line item' do
      get "/api/line_items/#{line_item.id}", format: :json
      expect(response).to be_success
      expect(json['line_item'].keys).to eq(%w(id quantity product_id order_id)) 
    end

    it 'should respond with success to valid data' do 
      patch "/api/line_items/#{line_item.id}", line_item: {quantity: 2}, format: :json      
      expect(response).to be_success
      expect(json['line_item']).to be_present
    end

    it 'should respond with error to invalid data' do
      patch "/api/line_items/#{line_item.id}", line_item: {quantity: -1}, format: :json      
      expect(response.status).to eq(422)
      expect(json['errors']).to be_present
    end

    it 'should return ' do
      delete "/api/line_items/#{line_item.id}", format: :json
      expect(response.status).to eq(200)
    end
  end
end