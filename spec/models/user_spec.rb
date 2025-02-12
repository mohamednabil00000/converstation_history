# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user, email: 'test@gmail.com') }

  describe 'Validations' do
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to validate_presence_of :password }
    it { should_not allow_value('test@test').for(:email).with_message('is not a valid format') }
    it { should allow_value('user@example.com').for(:email) }
    it { is_expected.to validate_presence_of :password }
    it { should validate_confirmation_of(:password) }
    it {
      is_expected.to validate_length_of(:password).is_at_least(8)
                                                  .with_message('should be more than 7 chars')
    }
    it {
      is_expected.to validate_length_of(:password).is_at_most(16)
                                                  .with_message('should be less than 17 chars')
    }
  end

  describe 'find_authenticated' do
    let(:user) { create(:user, email: 'test@test.com', password: '12345678', username: 'test') }

    context '#success' do
      it 'when user exists' do
        expect(described_class.find_authenticated(email: user.email, password: user.password)).to eq user
      end
    end

    context '#failure' do
      it 'when the password is wrong' do
        expect(described_class.find_authenticated(email: user.email, password: '1234568')).to be_nil
      end

      it 'when the email does not exist before' do
        expect(described_class.find_authenticated(email: 'test@tes.com', password: '12345678')).to be_nil
      end
    end
  end
end
