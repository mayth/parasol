require 'rails_helper'

RSpec.describe "teams/index", type: :view do
  before(:each) do
    assign(:teams, 2.times.map { create(:team) })
    assign(:challenges, 3.times.map { create(:challenge) })
  end

  it "renders a list of teams" do
    render
  end
end
