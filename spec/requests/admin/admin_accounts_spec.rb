require 'rails_helper'

RSpec.describe "Admin::Accounts", :type => :request do
  describe "GET /admin/accounts" do
    it "works! (now write some real specs)" do
      get admin_accounts_path
      expect(response).to have_http_status(200)
    end
  end
end
