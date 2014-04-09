module ApplicationHelper
  def within_team_registration_period?(time = nil)
    t = time || Time.zone.now
    t.between?(
      Setting.team_registrable_from, Setting.team_registrable_until
    )
  end

  def within_contest_period?(time = nil)
    t = time || Time.zone.now
    t.between?(
      Setting.contest_starts_at, Setting.contest_ends_at
    )
  end

  def markdown_render(md)
    @render ||=
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new,
        fenced_code_blocks: true, no_intra_emphasis: true
      )
    @render.render(md)
  end
end
