require 'rails_helper'

RSpec.describe "admin/players/index", type: :view do
  before(:each) do
    assign(:players, 2.times.map {
      player = create(:player)
      player.confirm!
      player
    })
  end

  it "renders a list of admin/players" do
    render
  end
end
