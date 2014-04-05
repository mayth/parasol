require 'spec_helper'

describe Post do
  describe 'scope public_only' do
    subject { Post.public_only }

    before do
      @public_posts = 3.times.map { create(:post, public_scope: 'public') }
      @private_posts = 3.times.map { create(:post, public_scope: 'player') }
    end

    it 'returns posts that are in the public' do
      expect(subject).to include(*@public_posts)
    end

    it 'does not return posts that are not in the public' do
      expect(subject).not_to include(*@private_posts)
    end
  end
end
