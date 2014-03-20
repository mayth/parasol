require "spec_helper"

describe Admin::PlayersController do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/admin/players").to route_to("admin/players#index")
    end

    it "routes to #new" do
      expect(get: "/admin/players/new").to route_to("admin/players#new")
    end

    it "routes to #show" do
      expect(get: "/admin/players/1").to route_to("admin/players#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/players/1/edit").to route_to("admin/players#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post: "/admin/players").to route_to("admin/players#create")
    end

    it "routes to #update" do
      expect(put: "/admin/players/1").to route_to("admin/players#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/players/1").to route_to("admin/players#destroy", :id => "1")
    end

  end
end
