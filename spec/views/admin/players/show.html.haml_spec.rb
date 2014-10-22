require 'rails_helper'

RSpec.describe "admin/players/show", type: :view do
  before(:each) do
    player = create(:player)
    player.confirm!
    @player = assign(:player, player)
  end

  it "renders attributes in <p>" do
    render
  end
end
