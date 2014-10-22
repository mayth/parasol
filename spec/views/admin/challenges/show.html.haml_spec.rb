require 'rails_helper'

RSpec.describe 'admin/challenges/show', type: :view do
  context 'for the challenge that are opened' do
    before(:each) do
      @challenge = create(:challenge)
      @challenge.open!
      assigns[:challenge] = @challenge
    end

    it 'renders genre and point' do
      render
      expect(rendered).to match @challenge.genre
      expect(rendered).to match @challenge.point.to_s
    end

    it 'renders flags' do
      render
      @challenge.flags.each do |flag|
        expect(rendered).to match flag.flag
      end
    end
  end
end
