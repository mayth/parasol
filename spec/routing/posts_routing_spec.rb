require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get('/posts')).to route_to('posts#index')
    end

    it 'does not route to #new' do
      expect(get('/posts/new')).not_to route_to('posts#new')
    end

    it 'routes to #show' do
      expect(get('/posts/1')).to route_to('posts#show', id: '1')
    end

    it 'does not route to #edit' do
      expect(get('/posts/1/edit')).not_to route_to('posts#edit', id: '1')
    end

    it 'does not route to #create' do
      expect(post('/posts')).not_to route_to('posts#create')
    end

    it 'does not route to #update' do
      expect(put('/posts/1')).not_to route_to('posts#update', id: '1')
    end

    it 'does not route to #destroy' do
      expect(delete('/posts/1')).not_to route_to('posts#destroy', id: '1')
    end

  end
end
