require 'rails_helper'

RSpec.describe "admin/accounts/show", :type => :view do
  before(:each) do
    @account = assign(:account, create(:admin))
  end

  it "renders attributes in <p>" do
    render
  end
end
