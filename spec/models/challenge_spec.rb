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

  describe '#opened?' do
    subject { @challenge.opened? }
    before do
      @challenge = create(:challenge)
    end
    context 'before it opens' do
      it 'returns false' do
        expect(subject).to be_false
      end
    end
    context 'after it opens' do
      before do
        @challenge.open!
      end
      it 'returns true' do
        expect(subject).to be_true
      end
    end
  end

  describe '#open!' do
    before do
      @challenge = create(:challenge)
      @challenge.close!
    end
    context 'when the challenge is closed' do
      it 'opens the challenge' do
        @challenge.open!
        expect(@challenge.opened?).to be_true
      end
    end

    context 'when the challenge is already opened' do
      before do
        @challenge.open!
      end
      it 'has no effects so the opened date is not changed' do
        expect{@challenge.open!}.not_to change {@challenge.opened_at}
      end
      it 'has no effects so the challenge is still opened' do
        expect(@challenge.opened?).to be_true
      end
    end
  end

  describe '#close!' do
    before do
      @challenge = create(:challenge)
    end
    context 'if the challenge is already closed' do
      it 'has no effects and the challenge still be closed' do
        @challenge.close!
        expect(@challenge.opened?).to be_false
      end
    end
    context 'if the challenge is opened' do
      before do
        @challenge.open!
      end
      it 'closes the challenge' do
        @challenge.close!
        expect(@challenge.opened?).to be_false
      end
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
