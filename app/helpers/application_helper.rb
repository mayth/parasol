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
        Redcarpet::Render::HTML.new(escape_html: true),
        fenced_code_blocks: true,
        disable_indented_code_blocks: true,
        no_intra_emphasis: true,
        tables: true
      )
    @render.render(md)
  end

  def first_break_point_setting
    case Setting[:first_break_points]
    when Array
      Setting[:first_break_points]
    when String
      s = Setting[:first_break_points]
      s = s[1..-2] if s.start_with?('[') && s.end_with?(']')
      s.split(',').map { |t| t.strip.to_f }
    when Numeric
      [Setting[:first_break_points]]
    when nil
      []
    else
    end
  end
end
