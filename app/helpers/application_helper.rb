module ApplicationHelper
  def within_team_registration_period?
    Time.zone.now.between?(
      Setting.team_registrable_from, Setting.team_registrable_until
    )
  end
end
