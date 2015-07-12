class Admin::PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/players
  # GET /admin/players.json
  def index
    @players = Player.order(:created_at)
  end

  # GET /admin/players/1
  # GET /admin/players/1.json
  def show
  end

  # GET /admin/players/new
  def new
    @player = Player.new
  end

  # GET /admin/players/1/edit
  def edit
  end

  # POST /admin/players
  # POST /admin/players.json
  def create
    @player = Player.new(admin_player_params)
    @player.confirm

    respond_to do |format|
      if @player.save
        format.html { redirect_to admin_player_url(@player), notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/players/1
  # PATCH/PUT /admin/players/1.json
  def update
    respond_to do |format|
      if @player.update(admin_player_params)
        format.html { redirect_to admin_player_url(@player), notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/players/1
  # DELETE /admin/players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to admin_players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_player_params
      params.require(:player).permit(:name, :email, :team_id)
    end
end
