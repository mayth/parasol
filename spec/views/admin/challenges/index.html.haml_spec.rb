require 'spec_helper'

describe "admin/challenges/index", :type => :view do
  before(:each) do
    assign(:challenges, 2.times.map {create(:challenge)})
  end

  it "renders a list of admin/challenges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
