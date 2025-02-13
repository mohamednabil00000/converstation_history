# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: %i[api controller] do
  describe '#create' do
    let!(:user) { create(:user, email: 'test@test.com', password: '12345678', username: 'test') }

    context 'when login is successful' do
      it 'when login is successful' do
        post_request(params: { email: 'test@test.com', password: '12345678' }, path: :create)
        expect(session).to have_key(:auth_token)
        expect(session[:auth_token]).not_to be_nil
        expect(response).to redirect_to('/projects')
      end
    end

    it 'when login is unsuccessful' do
      post_request(params: { email: 'test@test.com', password: '123456789' }, path: :create)
      expect(session[:auth_token]).to be_nil
      expect(flash[:notice]).to eq 'Wrong email or Password!'
      expect(response).to redirect_to('/')
    end
  end
end
