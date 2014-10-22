require 'spec_helper'

describe "admin/teams/show", :type => :view do
  before(:each) do
    @team = assign(:team, create(:team))
  end

  it "renders attributes in <p>" do
    render
  end
end
