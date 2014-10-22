require 'rails_helper'

RSpec.describe "admin/teams/index", type: :view do
  before(:each) do
    assign(:teams, 2.times.map {create(:team)})
  end

  it "renders a list of teams" do
    render
  end
end
