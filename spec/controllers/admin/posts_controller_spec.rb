require 'spec_helper'

describe Admin::PostsController do
  let(:admin) { create(:admin) }

  describe 'GET index' do
    it 'assigns all posts as @posts' do
      sign_in admin
      post = create(:post)
      get :index
      expect(assigns(:posts)).to eq [post]
    end
  end

  describe 'GET show' do
    it 'assigns the requested post as @post' do
      sign_in admin
      post = create(:post)
      get :show, id: post.to_param
      expect(assigns(:post)).to eq post
    end
  end

  describe 'GET new' do
    it 'assigns a new post as @post' do
      sign_in admin
      get :new
      expect(assigns(:post)).to be_a_new Post
    end
  end

  describe 'GET edit' do
    it 'assigns the requested post as @post' do
      sign_in admin
      post = create(:post)
      get :edit, id: post.to_param
      expect(assigns(:post)).to eq post
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Post' do
        sign_in admin
        expect { post :create, post: attributes_for(:post) }
          .to change(Post, :count).by(1)
      end

      it 'assigns a newly created post as @post' do
        sign_in admin
        post :create, post: attributes_for(:post)
        expect(assigns(:post)).to be_a Post
        expect(assigns(:post)).to be_persisted
      end

      it 'redirects to the created post' do
        sign_in admin
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to(admin_post_url(Post.last))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved post as @post' do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, post: { 'title' => '' }
        expect(assigns(:post)).to be_a_new Post
      end

      it 're-renders the "new" template' do
        sign_in admin
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, post: { 'title' => '' }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested post' do
        sign_in admin
        post = create(:post)
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Post)
          .to receive(:update).with('title' => 'New Title')
        put :update, id: post.to_param, post: { 'title' => 'New Title' }
      end

      it 'assigns the requested post as @post' do
        sign_in admin
        post = create(:post)
        put :update, id: post.to_param, post: attributes_for(:post)
        expect(assigns(:post)).to eq post
      end

      it 'redirects to the post' do
        sign_in admin
        post = create(:post)
        put :update, id: post.to_param, post: attributes_for(:post)
        expect(response).to redirect_to(admin_post_url(post))
      end
    end

    describe 'with invalid params' do
      it 'assigns the post as @post' do
        sign_in admin
        post = create(:post)
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, id: post.to_param, post: { 'title' => '' }
        expect(assigns(:post)).to eq post
      end

      it 're-renders the "edit" template' do
        sign_in admin
        post = create(:post)
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, id: post.to_param, post: { 'title' => '' }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested post' do
      sign_in admin
      post = create(:post)
      expect { delete :destroy, id: post.to_param }
        .to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      sign_in admin
      post = create(:post)
      delete :destroy, id: post.to_param
      expect(response).to redirect_to(admin_posts_url)
    end
  end

end
