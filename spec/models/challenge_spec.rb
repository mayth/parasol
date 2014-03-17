require 'spec_helper'

describe Challenge do
  describe '#point' do
    before do
      @challenge = create(:challenge)
      @challenge.flags.clear
      @points = [100, 200, 300]
      @points.each {|p| @challenge.flags << create(:flag, point: p)}
      @challenge.save!
    end
    subject { @challenge.point }
    it 'returns total point of flags' do
      expect(subject).to eq @points.inject(:+)
    end
  end

  describe '.generes' do
    subject { Challenge.genres }

    context 'when no challenges are registered' do
      before do
        Challenge.destroy_all
      end
      it 'returns empty array' do
        expect(subject).to be_empty
      end
    end

    context 'when some challenges are registered' do
      before do
        @genres = ['Binary', 'Forensics', 'Crypto', 'Misc']
        @genres.each {|g| create(:challenge, genre: g)}
        create(:challenge, genre: @genres.sample)
      end
      it 'returns all genres' do
        expect(subject).to eq @genres
      end
    end
  end
end
