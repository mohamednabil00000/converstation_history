# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::AuthenticateRequestService do
  include JsonWebToken

  describe '#call' do
    let(:user) { create(:user, email: 'test@test.com', password: '12345678', username: 'test') }

    context 'returns success' do
      let(:auth_header) { jwt_encode(user_id: user.id) }

      it 'return current user' do
        result = described_class.call(auth_header:)
        expect(result.success?).to be_truthy
        expect(result.current_user).to eq user
      end
    end

    context 'returns failure' do
      let(:fake_token) { 'token' }

      it 'when token is fake' do
        result = described_class.call(auth_header: fake_token)
        expect(result.success?).not_to be_truthy
      end
    end
  end
end
