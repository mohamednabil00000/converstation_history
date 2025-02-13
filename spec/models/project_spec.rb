# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:owner).class_name('User') }
    it { is_expected.to have_many(:comments).dependent(:destroy_async) }
  end

  describe 'scopes' do
    describe '.order_by_latest' do
      let!(:user) { create(:user, email: 'test@gmail.com') }
      let!(:project1) { create(:project, owner: user) }
      let!(:project2) { create(:project, owner: user) }
      let!(:project3) { create(:project, owner: user) }

      it 'returns projects ordered by created_at desc' do
        expect(described_class.order_by_latest).to eq([ project3, project2, project1 ])
      end
    end
  end
end
