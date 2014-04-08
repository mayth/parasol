require 'spec_helper'

describe Admin::AdjustmentsController do
  describe 'routing' do

    it 'routes to #index' do
      get('/admin/adjustments').should route_to('admin/adjustments#index')
    end

    it 'routes to #new' do
      get('/admin/adjustments/new').should route_to('admin/adjustments#new')
    end

    it 'routes to #show' do
      get('/admin/adjustments/1').should route_to('admin/adjustments#show', id: '1')
    end

    it 'routes to #edit' do
      get('/admin/adjustments/1/edit').should route_to('admin/adjustments#edit', id: '1')
    end

    it 'routes to #create' do
      post('/admin/adjustments').should route_to('admin/adjustments#create')
    end

    it 'routes to #update' do
      put('/admin/adjustments/1').should route_to('admin/adjustments#update', id: '1')
    end

    it 'routes to #destroy' do
      delete('/admin/adjustments/1').should route_to('admin/adjustments#destroy', id: '1')
    end

  end
end
