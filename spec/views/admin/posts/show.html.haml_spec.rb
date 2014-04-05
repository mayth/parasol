require 'spec_helper'

describe 'admin/posts/show' do
  before(:each) do
    @post = assign(:post, create(:post))
  end

  it 'renders attributes in <p>' do
    render
  end
end
