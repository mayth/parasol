require 'rails_helper'

RSpec.describe 'admin/adjustments/new', type: :view do
  before(:each) do
    assign(:adjustment, build(:adjustment))
  end

  it 'renders new adjustment form' do
    render

    assert_select 'form[action=?][method=?]', admin_adjustments_path, 'post' do
    end
  end
end
