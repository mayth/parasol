class Admin::SettingsController < ApplicationController
  before_action :authenticate_admin!

  # GET /admin/settings
  def index
  end

  # PATCH/PUT /admin/settings
  def update
    settings_params.each do |k, v|
      Setting[k] = v
    end
    respond_to do |format|
      format.html { redirect_to admin_settings_path, notice: 'Settings saved.' }
      format.json { head :no_content}
    end
  end

  private

    def settings_params
      params.require(:setting).permit!
    end
end