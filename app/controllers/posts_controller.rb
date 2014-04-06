class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :setup_render
  before_action :check_public_scope_restriction, only: [:show]

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
    end

    def setup_render
      @render = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new,
        fenced_code_blocks: true, no_intra_emphasis: true
      )
    end

    def check_public_scope_restriction
      if @post.public_scope == 'player' && !player_signed_in?
        @post = nil
        redirect_to new_player_session_path, status: :unauthorized
      end
    end
end
