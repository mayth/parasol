require 'spec_helper'

describe "Admin::Teams", :type => :request do
  describe "GET /admin/teams" do
    it "works! (now write some real specs)" do
      sign_in_as_a_valid_admin
      get admin_teams_path
      expect(response.status).to eq 200
    end
  end
end
