class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_player!, only: [:edit]
  before_action :api_authenticate_player!, only: [:update, :destroy]
  before_action :check_belonging!, only: [:edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    # sorting on latter step must be stable!
    t, t_nil = Team.all.partition { |x| x.last_submission(valid_only: true) }
    # sorting for teams which has some submissions.
    i = 0
    t = t.sort_by { |e| e.last_submission(valid_only: true).created_at }
         .sort_by { |e| [-e.point, i += 1] }
    # sorting for teams which has not any submissions.
    # this is required because there may be teams which does not have points
    # by submission but has some points by adjustment.
    i = 0
    t_nil = t_nil.sort_by { |e| e.created_at }
                 .sort_by { |e| [-e.point, i += 1] }
    @teams = t + t_nil
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
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

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :password)
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
end
