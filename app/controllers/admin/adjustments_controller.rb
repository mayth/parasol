# Controls point adjustments as an admin.
class Admin::AdjustmentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_adjustment, only: [:show, :edit, :update, :destroy]

  # GET /admin/adjustments(.json)
  #
  # Gets the all adjustments.
  def index
    @adjustments = Adjustment.all
  end

  # GET /admin/adjustments/:id(.json)
  #
  # Gets the specified adjustment.
  # @param id [Integer] ID for an adjustment.
  def show
  end

  # GET /admin/adjustments/new
  def new
    @adjustment = Adjustment.new
  end

  # GET /admin/adjustments/:id/edit
  #
  # @param id [Integer] ID for an adjustment.
  def edit
  end

  # POST /admin/adjustments(.json)
  #
  # Creates a new adjustment.
  # @param point [Integer] Point for adjustment
  # @param player_id [Integer] A player's ID to be applied point adjustment.
  # @param reason [String, nil] A reason of adjustment
  # @param challenge_id [Integer, nil]
  #   A challenge's ID related to point adjustment.
  def create
    @adjustment = Adjustment.new(admin_adjustment_params)

    respond_to do |format|
      if @adjustment.save
        format.html { redirect_to admin_adjustment_path(@adjustment), notice: 'Adjustment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @adjustment }
      else
        format.html { render action: 'new' }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/adjustments/:id(.json)
  #
  # Updates the specified adjustment.
  # @param id [Integer] An adjustment's ID to update.
  # @param point [Integer] Point for adjustment
  # @param player_id [Integer] A player's ID to be applied point adjustment.
  # @param reason [String, nil] A reason of adjustment
  # @param challenge_id [Integer, nil]
  #   A challenge's ID related to point adjustment.
  def update
    respond_to do |format|
      if @adjustment.update(admin_adjustment_params)
        format.html { redirect_to admin_adjustment_path(@adjustment), notice: 'Adjustment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/adjustments/:id(.json)
  #
  # Deletes the adjustment.
  # @param id [Integer] An adjustment's ID to delete.
  def destroy
    @adjustment.destroy
    respond_to do |format|
      format.html { redirect_to admin_adjustments_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_adjustment
      @adjustment = Adjustment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_adjustment_params
      params.require(:adjustment).permit(:player_id, :challenge_id, :point, :reason)
    end
end
