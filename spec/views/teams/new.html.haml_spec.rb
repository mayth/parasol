require 'spec_helper'

describe "teams/new" do
  before(:each) do
    assign(:team, stub_model(Team).as_new_record)
  end

  it "renders new team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", teams_path, "post" do
    end
  end
end
