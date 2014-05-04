class Admin::ChallengesController < ApplicationController
  before_action :set_admin_challenge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/challenges
  # GET /admin/challenges.json
  def index
    @challenges = Challenge.order(:created_at)
  end

  # GET /admin/challenges/1
  # GET /admin/challenges/1.json
  def show
  end

  # GET /admin/challenges/new
  def new
    @challenge = Challenge.new
    @challenge.flags.build
  end

  # GET /admin/challenges/1/edit
  def edit
  end

  # POST /admin/challenges
  # POST /admin/challenges.json
  def create
    @challenge = Challenge.new(admin_challenge_params)

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to admin_challenge_path(@challenge), notice: 'Challenge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @challenge }
      else
        format.html { render action: 'new' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/challenges/1
  # PATCH/PUT /admin/challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(admin_challenge_params)
        format.html { redirect_to admin_challenge_path(@challenge), notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/challenges/1
  # DELETE /admin/challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to admin_challenges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_challenge_params
      params.require(:challenge).permit!
    end
end
