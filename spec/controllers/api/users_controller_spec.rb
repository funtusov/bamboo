require 'spec_helper'
require 'shared_contexts'

describe Api::UsersController do
  include_context 'multitenancy'
  include_context 'visitor created'

  context 'when not logged in' do
    it 'should update the current user' do
      expect {
        patch :update, id: current_user.id, user: {first_name: 'Rose'}, format: :json
      }.to change{current_user.reload.first_name}.to('Rose')
    end

    it 'should not update non current user' do
      expect {
        patch :update, id: another_user.id, user: {first_name: 'Rose'}, format: :json
      }.not_to change{another_user.reload.first_name}
    end

    it 'should register current user if needed fields are passed' do
      expect {
        patch :update, id: current_user.id, user: {first_name: 'Rose', email: 'rose@nfm.com', password: '123123123', password_confirmation: '123123123'}, format: :json
      }.to change{current_user.reload.role}.from('visitor').to('user')
    end

    it 'should update password' do
      expect {
        patch :update, id: current_user.id, user: {password: '123123123', password_confirmation: '123123123'}, format: :json
      }.to change{current_user.reload.encrypted_password}
    end

    it 'should not register current user if needed fields are not passed' do
      expect {
        patch :update, id: current_user.id, user: {first_name: 'Rose'}, format: :json
      }.not_to change{current_user.reload.role}
    end
  end

  context 'when registered in' do 
    before :each do
      patch :update, id: current_user.id, user: {password: '123123123', password_confirmation: '123123123'}, format: :json
      # current_user.update_attributes(password: '123123123', password_confirmation: '123123123')
      # sign_in current_user
    end

    it 'should not update password if old password was not sent' do
      expect {
        patch :update, id: current_user.id, user: {password: '321321321', password_confirmation: '321321321'}, format: :json
      }.not_to change{current_user.reload.encrypted_password}
    end

    it 'should update password if old password was sent' do
      expect {
        patch :update, id: current_user.id, user: {password: '321321321', password_confirmation: '321321321', current_password: '123123123'}, format: :json
      }.to change{current_user.reload.encrypted_password}
    end

    it 'should update first name if old password was not sent' do
      expect {
        patch :update, id: current_user.id, user: {first_name: 'Dave'}, format: :json
      }.to change{current_user.reload.first_name}.to('Dave')
    end
  end
end