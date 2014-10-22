require 'spec_helper'

describe 'admin/adjustments/index', :type => :view do
  before(:each) do
    assign(:adjustments, 2.times.map { create(:adjustment) })
  end

  it 'renders a list of admin/adjustments' do
    render
  end
end
