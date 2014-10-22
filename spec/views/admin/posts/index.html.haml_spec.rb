require 'spec_helper'

describe 'admin/posts/index', :type => :view do
  before(:each) do
    assign(:posts, [
      create(:post),
      create(:post)
    ])
  end

  it 'renders a list of admin/posts' do
    render
  end
end
