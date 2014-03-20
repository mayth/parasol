require "spec_helper"

describe Admin::ChallengesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/challenges").should route_to("admin/challenges#index")
    end

    it "routes to #new" do
      get("/admin/challenges/new").should route_to("admin/challenges#new")
    end

    it "routes to #show" do
      get("/admin/challenges/1").should route_to("admin/challenges#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/challenges/1/edit").should route_to("admin/challenges#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/challenges").should route_to("admin/challenges#create")
    end

    it "routes to #update" do
      put("/admin/challenges/1").should route_to("admin/challenges#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/challenges/1").should route_to("admin/challenges#destroy", :id => "1")
    end

  end
end
