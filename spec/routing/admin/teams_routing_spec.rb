require "spec_helper"

describe Admin::TeamsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/admin/teams").to route_to("admin/teams#index")
    end

    it "routes to #new" do
      expect(get: "/admin/teams/new").to route_to("admin/teams#new")
    end

    it "routes to #show" do
      expect(get: "/admin/teams/1").to route_to("admin/teams#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/teams/1/edit").to route_to("admin/teams#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/admin/teams").to route_to("admin/teams#create")
    end

    it "routes to #update" do
      expect(put: "/admin/teams/1").to route_to("admin/teams#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/teams/1").to route_to("admin/teams#destroy", :id => "1")
    end

  end
end
