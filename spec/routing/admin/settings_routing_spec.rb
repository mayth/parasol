require "rails_helper"

RSpec.describe Admin::SettingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/admin/settings").to route_to("admin/settings#index")
    end

    it "routes to #update" do
      expect(put: "/admin/settings").to route_to("admin/settings#update")
    end
  end
end
