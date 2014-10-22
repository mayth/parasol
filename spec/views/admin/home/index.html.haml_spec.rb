require 'rails_helper'

RSpec.describe "admin/home/index.html.haml", type: :view do
  it 'shows the login page' do
    render
    expect(rendered).to include('Admin Home')
  end
end
