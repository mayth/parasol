require 'spec_helper'

describe "admin/players/new", :type => :view do
  before(:each) do
    assign(:player, build(:player))
  end

  it "renders new player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_players_path, "post" do
    end
  end
end
