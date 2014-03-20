require 'spec_helper'

describe "admin/players/edit" do
  before(:each) do
    player = create(:player)
    player.confirm!
    @player = assign(:player, player)
  end

  it "renders the edit player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_player_path(@player), "post" do
    end
  end
end
