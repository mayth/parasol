require 'rails_helper'

RSpec.describe "admin/challenges/index", type: :view do
  before(:each) do
    assign(:challenges, 2.times.map {create(:challenge)})
  end

  it "renders a list of admin/challenges" do
    render
  end
end
