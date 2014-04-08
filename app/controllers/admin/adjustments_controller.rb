class Admin::AdjustmentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_adjustment, only: [:show, :edit, :update, :destroy]

  # GET /admin/adjustments
  # GET /admin/adjustments.json
  def index
    @adjustments = Adjustment.all
  end

  # GET /admin/adjustments/1
  # GET /admin/adjustments/1.json
  def show
  end

  # GET /admin/adjustments/new
  def new
    @adjustment = Adjustment.new
  end

  # GET /admin/adjustments/1/edit
  def edit
  end

  # POST /admin/adjustments
  # POST /admin/adjustments.json
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

  # PATCH/PUT /admin/adjustments/1
  # PATCH/PUT /admin/adjustments/1.json
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

  # DELETE /admin/adjustments/1
  # DELETE /admin/adjustments/1.json
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
      params.require(:adjustment).permit!
    end
end
