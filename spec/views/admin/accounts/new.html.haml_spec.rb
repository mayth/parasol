require 'rails_helper'

RSpec.describe "admin/accounts/new", :type => :view do
  before(:each) do
    assign(:account, build(:admin))
  end

  it "renders new admin/account form" do
    render

    assert_select "form[action=?][method=?]", admin_accounts_path, "post" do
    end
  end
end
