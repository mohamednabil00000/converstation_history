# frozen_string_literal: true

require 'rails_helper'

class TestApplicationController < ApplicationController; end

RSpec.describe TestApplicationController, type: %i[api controller] do
  let(:user) { create(:user, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: user.id) }

  controller(TestApplicationController) do
    def index
      head :ok
    end
  end

  describe '#authorize' do
    context 'return unauthorized' do
      it 'session does not contain auth token' do
        get_request(path: :index)
        expect(response).to have_http_status(:unauthorized)
      end
      it 'token is fake' do
        append_auth_token_session(token: 'token')
        get_request(path: :index)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it 'returns created' do
      append_auth_token_session(token:)
      get_request(path: :index)
      expect(response).to have_http_status(:ok)
    end
  end
end
