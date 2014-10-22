require 'spec_helper'

describe 'posts/index', :type => :view do
  before(:each) do
    posts = 2.times.map do
      create(:post, title: 'Awesome Title', body: 'Incredible!')
    end
    assign(:posts, posts)
    assign(:render, Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new,
        fenced_code_blocks: true, no_intra_emphasis: true
    ))
  end

  it 'renders a list of posts' do
    render
    assert_select 'article>h1', text: 'Awesome Title', count: 2
    assert_select 'article>.body', text: 'Incredible!', count: 2
  end
end
