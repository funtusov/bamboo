require 'spec_helper'
require 'shared_contexts'

describe 'Registrations API' do
  include_context "multitenancy"

  context 'with complete data' do
    let(:params) { attributes_for(:user) }

    it 'should create the user' do
      expect {
        post '/api/user', user: params, format: :json      
      }.to change{User.count}.by(1)
    end

    it 'should return the user json' do
      post '/api/user', user: params, format: :json
      expect(response).to be_success
      expect(json['user'].keys).to eq(%w(id email))
    end
  end

  context 'with incomplete data' do
    let(:params) { {email: 'test@mail.com'} }

    it 'should not create the user' do
      expect {
        post '/api/user', user: params, format: :json
      }.not_to change{User.count}
    end

    it 'should return errors' do
      post '/api/user', user: params, format: :json
      expect(response.status).to eq(422)
      expect(json['errors'].keys).to eq(%w(password))
    end
  end
end