module ApplicationHelper
  def within_team_registration_period?
    Time.zone.now.between?(
      Setting.team_registrable_from, Setting.team_registrable_until
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
