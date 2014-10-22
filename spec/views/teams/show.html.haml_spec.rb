require 'spec_helper'

describe "teams/show" do
  before(:each) do
    @team = assign(:team, create(:team))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
