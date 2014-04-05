require "spec_helper"

describe Admin::PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/posts").should route_to("admin/posts#index")
    end

    it "routes to #new" do
      get("/admin/posts/new").should route_to("admin/posts#new")
    end

    it "routes to #show" do
      get("/admin/posts/1").should route_to("admin/posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/posts/1/edit").should route_to("admin/posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/posts").should route_to("admin/posts#create")
    end

    it "routes to #update" do
      put("/admin/posts/1").should route_to("admin/posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/posts/1").should route_to("admin/posts#destroy", :id => "1")
    end

  end
end
