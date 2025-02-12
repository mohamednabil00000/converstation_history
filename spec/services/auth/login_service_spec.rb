# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::LoginService do
  include JsonWebToken

  describe '#call' do
    let(:user) { create(:user, email: 'test@test.com', password: '12345678', username: 'test') }

    context '#success' do
      it 'when login successfully' do
        result = described_class.call(email: user.email, password: user.password)
        expect(result.success?).to be_truthy
        expect(result.current_user).to eq user
      end
    end

    context '#failure' do
      it 'when the password is wrong' do
        result = described_class.call(email: user.email, password: '1234568')

        expect(result.success?).to be_falsey
        expect(result.errors).to match_array([ 'Wrong email or Password!' ])
      end

      it 'when the email does not exist before' do
        result = described_class.call(email: 'test@tes.com', password: '12345678')

        expect(result.success?).to be_falsey
        expect(result.errors).to match_array([ 'Wrong email or Password!' ])
      end
    end
  end
end
