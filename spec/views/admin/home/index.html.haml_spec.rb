require 'spec_helper'

describe "admin/home/index.html.haml" do
  it 'shows the login page' do
    render
    expect(rendered).to include('Admin Home')
  end
end
