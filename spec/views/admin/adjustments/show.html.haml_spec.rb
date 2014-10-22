require 'rails_helper'

RSpec.describe "admin/adjustments/show", type: :view do
  before(:each) do
    @adjustment = assign(:adjustment, create(:adjustment))
  end

  it "renders attributes in <p>" do
    render
  end
end
