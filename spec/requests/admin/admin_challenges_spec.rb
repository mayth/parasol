require 'spec_helper'

describe "Admin::Challenges" do
  describe "GET /admin_challenges" do
    it "works! (now write some real specs)" do
      sign_in_as_a_valid_admin
      get admin_challenges_path
      response.status.should be(200)
    end
  end
end
