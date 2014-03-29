class HomeController < ApplicationController
  def index
    @challenges = Challenge.opened
  end

  def rules
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    @content = md.render(Setting.rules)
  end
end
