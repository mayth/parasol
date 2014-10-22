require "rails_helper"

RSpec.describe Admin::ChallengesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/admin/challenges").to route_to("admin/challenges#index")
    end

    it "routes to #new" do
      expect(get: "/admin/challenges/new").to route_to("admin/challenges#new")
    end

    it "routes to #show" do
      expect(get: "/admin/challenges/1").to route_to("admin/challenges#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/challenges/1/edit").to route_to("admin/challenges#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post: "/admin/challenges").to route_to("admin/challenges#create")
    end

    it "routes to #update" do
      expect(put: "/admin/challenges/1").to route_to("admin/challenges#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/challenges/1").to route_to("admin/challenges#destroy", :id => "1")
    end

  end
end
