require 'spec_helper'

describe "admin/teams/index" do
  before(:each) do
    assign(:teams, 2.times.map {create(:team)})
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
