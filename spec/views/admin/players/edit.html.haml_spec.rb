require 'rails_helper'

RSpec.describe "admin/players/edit", type: :view do
  before(:each) do
    player = create(:player)
    player.confirm
    @player = assign(:player, player)
  end

  it "renders the edit player form" do
    render

    assert_select "form[action=?][method=?]", admin_player_path(@player), "post" do
    end
  end
end
