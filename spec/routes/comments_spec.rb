# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/projects/:project_id/comments').to route_to('comments#create', project_id: ':project_id')
    end

    it 'routes to #new' do
      expect(get: '/projects/:project_id/comments/new').to route_to('comments#new', project_id: ':project_id')
    end

    it 'routes to #index' do
      expect(get: '/projects/:project_id/comments').to route_to('comments#index', project_id: ':project_id')
    end

    it 'routes to #destroy' do
      expect(delete: '/projects/:project_id/comments/:id').to route_to('comments#destroy', project_id: ':project_id', id: ':id')
    end
  end
end
