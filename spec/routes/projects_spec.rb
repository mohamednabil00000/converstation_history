# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/projects').to route_to('projects#create')
    end

    it 'routes to #new' do
      expect(get: '/projects/new').to route_to('projects#new')
    end

    it 'routes to #index' do
      expect(get: '/projects').to route_to('projects#index')
    end

    it 'routes to #edit' do
      expect(get: '/projects/:id/edit').to route_to('projects#edit', id: ':id')
    end

    it 'routes to #show' do
      expect(get: '/projects/:id').to route_to('projects#show', id: ':id')
    end

    it 'routes to #update' do
      expect(put: '/projects/:id').to route_to('projects#update', id: ':id')
    end

    it 'routes to #destroy' do
      expect(delete: '/projects/:id').to route_to('projects#destroy', id: ':id')
    end
  end
end
