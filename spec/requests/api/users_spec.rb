require 'spec_helper'
require 'shared_contexts'

describe 'Users API' do
  include_context 'multitenancy'
  include_context 'visitor created'

  context 'with complete data' do
    it 'should return the current user' do
      get "/api/users/#{current_user.id}", format: :json      
      expect(response).to be_success
      expect(json).to have_key 'carts'
      expect(json['user'].keys).to eq(%w(id email cart_id))
    end

    it 'should return 401 if the requested user is not current_user' do
      get "/api/users/#{another_user.id}", format: :json      
      expect(response.status).to eq(401)
    end
  end
end