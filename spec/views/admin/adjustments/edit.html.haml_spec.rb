require 'rails_helper'

RSpec.describe 'admin/adjustments/edit', type: :view do
  before(:each) do
    @adjustment = assign(:adjustment, create(:adjustment))
  end

  it 'renders the edit admin_adjustment form' do
    render

    assert_select 'form[action=?][method=?]', admin_adjustment_path(@adjustment), 'post' do
    end
  end
end
