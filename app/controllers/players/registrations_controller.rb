class Players::RegistrationsController < Devise::RegistrationsController
  def new
    @page_id = :sign_up
    super
  end

  def create
    param = sign_up_params
    team_id = param.delete(:team_id)
    team_password = param.delete(:team_password)

    # build_resource
    self.resource = resource_class.new_with_session(param, session)

    # team authentication
    can_save = true
    begin
      team = Team.find(team_id)
    rescue ActiveRecord::RecordNotFound
      puts 'Team not found'
      resource.errors.add(:team, 'was not found')
      can_save = false
    end
    if team.authenticate(team_password)
      resource.team = team
    else
      resource.errors.add(:team, 'password mismatched')
      can_save = false
    end

    respond_to do |format|
      if can_save && resource.save
        format.html { redirect_to new_player_session_path, notice: 'Confirmation mail was sent. Please check your mailbox.' }
      else
        format.html { render 'players/registrations/new', alert: 'Failed to sign up. Check the message!' }
      end
    end
  end

  private

    def sign_up_params
      devise_parameter_sanitizer.for(:sign_up) << :team_id
      devise_parameter_sanitizer.for(:sign_up) << :team_password
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.sanitize(:sign_up)
    end

    def account_update_params
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.sanitize(:account_update)
    end
end
