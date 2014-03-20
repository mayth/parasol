require 'spec_helper'

describe "admin/players/index" do
  before(:each) do
    assign(:players, 2.times.map {
      player = create(:player)
      player.confirm!
      player
    })
  end

  it "renders a list of admin/players" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
