require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  it 'should become a user if password and required fields are set' do
    expect{
      user.update_attributes(password: '123123123', password_confirmation: '123123123', email: 'user@mail.com')
    }.to change{user.reload.role}.from('visitor').to('user')
  end
end