require 'spec_helper'

describe "admin/teams/edit", :type => :view do
  before(:each) do
    @team = assign(:team, create(:team))
  end

  it "renders the edit team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_team_path(@team), "post" do
    end
  end
end
