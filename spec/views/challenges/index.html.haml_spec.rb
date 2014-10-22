require 'rails_helper'

RSpec.describe "challenges/index.html.haml", type: :view do
  context 'when no challenges are available' do
    it 'renders nothing but "not-available" message' do
      assign(:challenges, [])
      render
      expect(rendered).to include('No challenges')
    end
  end
  context 'when some challenges are available' do
    before do
      @genres = ['Binary', 'Forensics', 'Misc']
      @challenges = @genres.map {|g| create(:challenge, genre: g)}
      @challenges.each {|c| c.open!}
    end
    it 'renders challenges list' do
      assign(:genres, @genres)
      assign(:challenges, @challenges)
      render
      expect(rendered).to include(*@genres)
      expect(rendered).to include(*@challenges.map{|c| c.point.to_s})
      expect(rendered).to include(*@challenges.map{|c| c.name})
    end
  end
end
