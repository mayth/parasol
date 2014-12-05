require 'rails_helper'

RSpec.describe "admin/accounts/edit", :type => :view do
  before(:each) do
    @account = assign(:account, create(:admin))
  end

  it "renders the edit admin/account form" do
    render

    assert_select "form[action=?][method=?]", admin_account_path(@account), "post" do
    end
  end
end
