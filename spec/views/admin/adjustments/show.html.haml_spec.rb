require 'spec_helper'

describe "admin/adjustments/show" do
  before(:each) do
    @adjustment = assign(:adjustment, create(:adjustment))
  end

  it "renders attributes in <p>" do
    render
  end
end
