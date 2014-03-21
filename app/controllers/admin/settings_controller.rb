class Admin::SettingsController < ApplicationController
  before_action :authenticate_admin!

  # GET /admin/settings
  def index
  end

  # PATCH/PUT /admin/settings
  def update
  end

  private

    def settings_params
      params.require(:setting).permit!
    end
end