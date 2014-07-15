require 'spec_helper'
require 'shared_contexts'

describe ApplicationController do
  include_context 'multitenancy'

  it 'should set current_shop to the correct shop' do
    expect(controller.current_shop).to eq(shop)
  end

  context 'when the visitor is new' do
    it 'should create a new visitor user instance' do 
      expect {
        get :index
      }.to change{shop.users.visitors.count}.by(1)
    end
  end

  context 'when the visitor is returning' do
    before :each do
      get :index
    end

    it 'should not create a new visitor user instance' do
      expect {
        get :index
      }.not_to change{shop.users.visitors.count}
    end

    it 'should correctly identify the returning user' do
      get :index
      expect(controller.current_user).to eq(shop.users.first)
    end
  end

  context 'when the visitor was in another shop before' do

  end
end