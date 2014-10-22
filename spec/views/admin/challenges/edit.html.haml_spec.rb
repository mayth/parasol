require 'spec_helper'

describe "admin/challenges/edit", :type => :view do
  before(:each) do
    @challenge = assign(:challenge, create(:challenge))
  end

  it "renders the edit admin_challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_challenge_path(@challenge), "post" do
    end
  end
end
