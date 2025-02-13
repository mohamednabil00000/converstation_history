# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: %i[api controller] do
  let(:user) { create(:user, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: user.id) }

  before do
    append_auth_token_session(token:)
  end

  describe '#create' do
    let(:project) { create(:project, owner: user) }
    let(:comment_params) { attributes_for(:comment).merge(project_id: project.id) }

    it 'creates a new comment' do
      expect do
        post :create, params: { project_id: project.id, comment: comment_params }
      end.to change(Comment, :count).by(1)
    end
  end
end
