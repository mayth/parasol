class HomeController < ApplicationController
  before_action :set_page_id, except: %i(index)
  def index
    @challenges = Challenge.opened
    @posts =
      (accessible_to_secret_zone? ? Post.all : Post.public_only)
      .order(updated_at: :desc)
    @teams = Team.ranking
  end

  def rules
  end

  def ranking
    @teams = Team.ranking
  end

  private

    def set_page_id
      @page_id = action_name
    end
end
