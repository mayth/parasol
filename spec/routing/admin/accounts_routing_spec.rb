require "rails_helper"

RSpec.describe Admin::AccountsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/accounts").to route_to("admin/accounts#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/accounts/new").to route_to("admin/accounts#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/accounts/1").to route_to("admin/accounts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/accounts/1/edit").to route_to("admin/accounts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/accounts").to route_to("admin/accounts#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/accounts/1").to route_to("admin/accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/accounts/1").to route_to("admin/accounts#destroy", :id => "1")
    end

  end
end
