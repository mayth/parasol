require 'spec_helper'

describe 'posts/show' do
  before(:each) do
    @post = assign(:post, create(:post, title: 'Title', body: 'MyText'))
    assign(:render, Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new,
        fenced_code_blocks: true, no_intra_emphasis: true
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
