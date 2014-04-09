class HomeController < ApplicationController
  def index
    @challenges = Challenge.opened
    @posts =
      (player_signed_in? ? Post.all : Post.public_only)
      .order(updated_at: :desc)
  end

  def rules
    @page_id = :rules
  end
end
