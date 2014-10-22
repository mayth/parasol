require 'rails_helper'

RSpec.describe "admin/challenges/new", type: :view do
  let(:admin) {create(:admin)}
  before(:each) do
    assign(:challenge, build(:challenge))
  end

  it "renders new challenge form" do
    sign_in admin
    render

    assert_select "form[action=?][method=?]", admin_challenges_path, "post" do
    end
  end
end
