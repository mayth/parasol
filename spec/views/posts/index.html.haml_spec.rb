require 'spec_helper'

describe 'posts/index' do
  before(:each) do
    posts = 2.times.map do
      create(:post, title: 'Awesome Title', body: 'Incredible!')
    end
    assign(:posts, posts)
  end

  it 'renders a list of posts' do
    render
    assert_select 'tr>td', text: 'Awesome Title', count: 2
    assert_select 'tr>td', text: 'Incredible!', count: 2
  end
end
