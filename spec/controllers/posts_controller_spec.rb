require 'spec_helper'

describe PostsController do
  let(:player) do
    player = create(:player)
    player.confirm!
    player
  end

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
          get :show, id: post.to_param
          expect(assigns(:post)).not_to eq post
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
