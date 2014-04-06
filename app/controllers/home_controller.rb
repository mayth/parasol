class HomeController < ApplicationController
  def index
    @challenges = Challenge.opened
    @posts =
      (player_signed_in? ? Post.all : Post.public_only)
      .order(updated_at: :desc)
    @renderer = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new,
      fenced_code_blocks: true, no_intra_emphasis: true
    )
  end

  def rules
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    @content = md.render(Setting.rules)
  end
end
