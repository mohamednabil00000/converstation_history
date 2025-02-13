# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: %i[api controller] do
  let(:user) { create(:user, email: 'test@gmail.com') }
  let(:token) { jwt_encode(user_id: user.id) }

  before do
    append_auth_token_session(token:)
  end

  describe '#index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    subject { create(:project, owner: user) }

    it 'returns http success' do
      get :show, params: { id: subject.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#edit' do
    context 'when the user is the owner of the project' do
      let!(:project) { create(:project, owner: user) }

      it 'returns http success' do
        get :edit, params: { id: project.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not the owner of the project' do
      let!(:user2) { create(:user, email: 'hello@gmail.com') }
      let!(:project) { create(:project, owner: user2) }

      it 'returns unauthorized' do
        get :edit, params: { id: project.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#create' do
    let(:project_params) { attributes_for(:project) }

    it 'creates a new project' do
      expect do
        post :create, params: { project: project_params }
      end.to change(Project, :count).by(1)
    end
  end

  describe '#update' do
    context 'when the user is the owner of the project' do
      let!(:project) { create(:project, owner: user) }
      let(:project_params) { attributes_for(:project) }

      it 'updates the project' do
        put :update, params: { id: project.id, project: project_params }
        expect(project.reload.name).to eq(project_params[:name])
      end
    end

    context 'when the user is not the owner of the project' do
      let!(:user2) { create(:user, email: 'hello@gmail.com') }
      let!(:project) { create(:project, owner: user2) }
      let(:project_params) { attributes_for(:project) }

      it 'returns unauthorized' do
        put :update, params: { id: project.id, project: project_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#delete' do
    context 'when the user is the owner of the project' do
      let!(:project) { create(:project, owner: user) }

      it 'deletes the project' do
        expect do
          delete :destroy, params: { id: project.id }
        end.to change(Project, :count).by(-1)
      end
    end

    context 'when the user is not the owner of the project' do
      let!(:user2) { create(:user, email: 'hello@gmail.com') }
      let!(:project) { create(:project, owner: user2) }

      it 'returns unauthorized' do
        delete :destroy, params: { id: project.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
