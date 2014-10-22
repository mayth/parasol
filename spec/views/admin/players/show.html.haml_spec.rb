require 'spec_helper'

describe "admin/players/show", :type => :view do
  before(:each) do
    player = create(:player)
    player.confirm!
    @player = assign(:player, player)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
