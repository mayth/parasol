require 'rails_helper'

RSpec.describe "admin/accounts/index", :type => :view do
  before(:each) do
    assign(:accounts, [
      create(:admin),
      create(:admin)
    ])
  end

  it "renders a list of admin/accounts" do
    render
  end
end
