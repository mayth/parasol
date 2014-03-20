require 'spec_helper'

describe "admin/challenges/show" do
  before(:each) do
    @challenge = assign(:challenge, create(:challenge))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
