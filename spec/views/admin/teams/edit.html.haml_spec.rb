require 'rails_helper'

RSpec.describe "admin/teams/edit", type: :view do
  before(:each) do
    @team = assign(:team, create(:team))
  end

  it "renders the edit team form" do
    render

    assert_select "form[action=?][method=?]", admin_team_path(@team), "post" do
    end
  end
end
