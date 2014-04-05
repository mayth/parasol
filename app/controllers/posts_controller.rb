class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :check_public_scope_restriction, only: [:show]

  # GET /posts
  # GET /posts.json
  def index
    if player_signed_in?
      @posts = Post.all
    else
      @posts = Post.public_only
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def check_public_scope_restriction
      if @post.public_scope == 'player' && !player_signed_in?
        @post = nil
        redirect_to new_player_session_path, status: :unauthorized
      end
    end
end