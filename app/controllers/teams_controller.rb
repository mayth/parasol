class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!, only: [:edit]
  before_action :api_authenticate_player!, only: [:update, :destroy]
  before_action :check_belonging!, only: [:edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.order(:created_at)
    @challenges = Challenge.opened.order(:created_at)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @page_id = :team_registration
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    unless team_registrable?
      respond_to do |format|
        format.html { redirect_to teams_path, alert: 'Team registration is closed.' }
        format.json { render json: { status: 'closed' } }
      end
      return
    end

    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    param = team_params
    # There is no need to be changed if the password field is empty.
    param.delete(:password) if param[:password].blank?
    respond_to do |format|
      if @team.update(param)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(
        :name, :email, :password, :password_confirmation
      )
    end

    ### Filters

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    def api_authenticate_player!
      redirect_to new_player_session_path, status: :unauthorized unless player_signed_in?
    end

    def check_belonging!
      redirect_to teams_url, status: :unauthorized unless @team == current_player.team
    end

    ### helpers

    def team_registrable?
      ApplicationController.helpers.within_team_registration_period?
    end
end
