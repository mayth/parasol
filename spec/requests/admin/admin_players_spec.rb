require 'spec_helper'

describe "Admin::Players" do
  describe "GET /admin_players" do
    it "works! (now write some real specs)" do
      sign_in_as_a_valid_admin
      get admin_players_path
      expect(response.status).to eq 200
    end
  end
end
