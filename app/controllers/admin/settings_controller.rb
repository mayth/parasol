class Admin::SettingsController < ApplicationController
  before_action :authenticate_admin!

  # GET /admin/settings
  def index
  end

  # PATCH/PUT /admin/settings
  def update
    converter = {
      submit_burst_count: -> (s) { s.to_i },
      submit_burst_time:  -> (s) { s.to_i },
      cooling_down:       -> (s) { s.to_i },
      team_registrable_from:  -> (s) { Time.parse(s) },
      team_registrable_until: -> (s) { Time.parse(s) },
      contest_starts_at: -> (s) { Time.parse(s) },
      contest_ends_at:  -> (s) { Time.parse(s) }
    }
    settings_params.each do |k, v|
      Setting[k] = converter.key?(k.to_sym) ? converter[k.to_sym].call(v) : v
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