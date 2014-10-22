require 'rails_helper'

RSpec.describe "Admin::Adjustments", type: :request do
  describe "GET /admin/adjustments" do
    it "works! (now write some real specs)" do
      sign_in_as_a_valid_admin
      get admin_adjustments_path
      expect(response.status).to be(200)
    end
  end
end
