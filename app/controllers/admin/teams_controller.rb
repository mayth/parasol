class Admin::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/teams
  # GET /admin/teams.json
  def index
    @teams = Team.order(:created_at)
  end

  # GET /admin/teams/1
  # GET /admin/teams/1.json
  def show
  end

  # GET /admin/teams/new
  def new
    @team = Team.new
  end

  # GET /admin/teams/1/edit
  def edit
  end

  # POST /admin/teams
  # POST /admin/teams.json
  def create
    @team = Team.new(admin_team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to admin_team_path(@team), notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/teams/1
  # PATCH/PUT /admin/teams/1.json
  def update
    respond_to do |format|
      if @team.update(admin_team_params)
        format.html { redirect_to admin_team_path(@team), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/teams/1
  # DELETE /admin/teams/1.json
  def destroy
    respond_to do |format|
      if @team.destroy
        format.html { redirect_to admin_teams_url }
        format.json { head :no_content }
      else
        format.html do
          redirect_to :back,
                      alert: @team.errors.full_messages.join("\n")
        end
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_team_params
      params.require(:team).permit(:name, :email, :password)
    end
end
