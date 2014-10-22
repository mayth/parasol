require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:player) do
    player = create(:player)
    player.confirm!
    player
  end

  let(:admin) { create(:admin) }

  describe 'GET index' do
    context 'if the user is not signed in' do
      before do
        sign_out player
      end

      it 'assigns posts which are in the public as @posts' do
        posts =
        [
          create(:post, public_scope: 'public'),
          create(:post, public_scope: 'player')
        ]
        get :index
        expect(assigns(:posts)).to include posts[0]
      end

      context 'but the user signed in as an admin' do
        before do
          sign_in admin
        end
        
        it 'assigns all posts as @ posts' do
          posts =
          [
            create(:post, public_scope: 'public'),
            create(:post, public_scope: 'player')
          ]
          get :index
          expect(assigns(:posts)).to include(*posts)
        end
      end
    end

    context 'if the player signed in' do
      before do
        sign_in player
      end

      it 'assigns all posts as @posts' do
        posts =
        [
          create(:post, public_scope: 'public'),
          create(:post, public_scope: 'player')
        ]
        get :index
        expect(assigns(:posts)).to include(*posts)
      end
    end
  end

  describe 'GET show' do
    context 'if the user is not signed in' do
      before do
        sign_out player
      end

      context 'with the public post' do
        it 'assigns the requested post as @post' do
          post = create(:post, public_scope: 'public')
          get :show, id: post.to_param
          expect(assigns(:post)).to eq post
        end
      end

      context 'with the non-public post' do
        it 'does not assign the requested post as @post' do
          post = create(:post, public_scope: 'player')
          expect { get :show, id: post.to_param }
            .to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'if the player signed in' do
      before do
        sign_in player
      end

      context 'with the public post' do
        it 'assigns the requested post as @post' do
          post = create(:post, public_scope: 'public')
          get :show, id: post.to_param
          expect(assigns(:post)).to eq post
        end
      end

      context 'with the non-public post' do
        it 'assigns the requested post as @post' do
          # for players post
          post = create(:post, public_scope: 'player')
          get :show, id: post.to_param
          expect(assigns(:post)).to eq post
        end
      end
    end
  end
end
