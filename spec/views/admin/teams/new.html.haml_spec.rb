require 'spec_helper'

describe "admin/teams/new" do
  before(:each) do
    assign(:team, build(:team))
  end

  it "renders new team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_teams_path, "post" do
    end
  end
end
