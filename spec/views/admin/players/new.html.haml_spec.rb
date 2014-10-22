require 'rails_helper'

RSpec.describe "admin/players/new", type: :view do
  before(:each) do
    assign(:player, build(:player))
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", admin_players_path, "post" do
    end
  end
end
