# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
    it { is_expected.to belong_to(:project) }
  end

  describe 'scopes' do
    describe '.order_by_latest' do
      let!(:user) { create(:user, email: 'test@gmail.com') }
      let!(:project) { create(:project, owner: user) }
      let!(:comment1) { create(:comment, project:, author: user) }
      let!(:comment2) { create(:comment, project:, author: user) }
      let!(:comment3) { create(:comment, project:, author: user) }

      it 'returns the comments ordered by created_at' do
        expect(project.comments.order_by_latest).to eq([ comment3, comment2, comment1 ])
      end
    end
  end
end
