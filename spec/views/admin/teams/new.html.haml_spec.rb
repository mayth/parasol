require 'rails_helper'

RSpec.describe "admin/teams/new", type: :view do
  before(:each) do
    assign(:team, build(:team))
  end

  it "renders new team form" do
    render

    assert_select "form[action=?][method=?]", admin_teams_path, "post" do
    end
  end
end
