require 'rails_helper'

RSpec.describe 'admin/posts/show', type: :view do
  before(:each) do
    @post = assign(:post, create(:post))
  end

  it 'renders attributes in <p>' do
    render
  end
end
