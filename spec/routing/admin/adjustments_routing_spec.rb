require 'spec_helper'

describe Admin::AdjustmentsController, :type => :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get('/admin/adjustments')).to route_to('admin/adjustments#index')
    end

    it 'routes to #new' do
      expect(get('/admin/adjustments/new')).to route_to('admin/adjustments#new')
    end

    it 'routes to #show' do
      expect(get('/admin/adjustments/1')).to route_to('admin/adjustments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get('/admin/adjustments/1/edit')).to route_to('admin/adjustments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post('/admin/adjustments')).to route_to('admin/adjustments#create')
    end

    it 'routes to #update' do
      expect(put('/admin/adjustments/1')).to route_to('admin/adjustments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete('/admin/adjustments/1')).to route_to('admin/adjustments#destroy', id: '1')
    end

  end
end
