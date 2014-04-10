class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :set_page_id

  # GET /posts
  # GET /posts.json
  def index
    @posts =
      (player_signed_in? ? Post.all : Post.public_only)
      .order(updated_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      unless @post.public_scope == 'public' || player_signed_in?
        fail ActiveRecord::RecordNotFound
      end
    end

    def set_page_id
      @page_id = :announcements
    end
end
