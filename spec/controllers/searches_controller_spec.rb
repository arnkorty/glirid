require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:account) { create :account}
  #before {  user }
  #login_account account
  # login!

  describe "GET 'index'" do
    context 'access index after login' do
      it 'returns http success' do
        sign_in account
        get 'index'
        response.should be_success
      end

      it 'returns http failure' do
        get 'index'
        response.should_not be_success
      end
    end
  end
end
