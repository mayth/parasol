require "spec_helper"

describe Admin::PlayersController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/players").should route_to("admin/players#index")
    end

    it "routes to #new" do
      get("/admin/players/new").should route_to("admin/players#new")
    end

    it "routes to #show" do
      get("/admin/players/1").should route_to("admin/players#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/players/1/edit").should route_to("admin/players#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/players").should route_to("admin/players#create")
    end

    it "routes to #update" do
      put("/admin/players/1").should route_to("admin/players#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/players/1").should route_to("admin/players#destroy", :id => "1")
    end

  end
end
