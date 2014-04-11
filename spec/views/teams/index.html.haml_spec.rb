require 'spec_helper'

describe "teams/index" do
  before(:each) do
    assign(:teams, 2.times.map { create(:team) })
    assign(:challenges, 3.times.map { create(:challenge) })
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
