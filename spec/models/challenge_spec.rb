require 'rails_helper'

RSpec.describe Challenge, type: :model do
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
    context 'when it is closed' do
      context 'because it is a new challenge' do
        it 'returns false' do
          expect(subject).to be false
        end
      end
      context 'because the time to open has not come yet' do
        before do
          @challenge.opened_at = Time.now.tomorrow
        end
        it 'returns false' do
        end
      end
    end
    context 'after it opens' do
      before do
        @challenge.open!
      end
      it 'returns true' do
        expect(subject).to be true
      end
    end
  end

  describe '#open!' do
    before do
      @challenge = create(:challenge)
      @challenge.close!
    end
    context 'when the challenge is closed' do
      context 'without the parameter' do
        it 'opens the challenge immediately' do
          @challenge.open!
          expect(@challenge.opened?).to be true
        end
      end

      context 'with the parameter' do
        context 'which represents the future datetime' do
          before do
            @time = Time.zone.now.tomorrow
            @challenge.open!(@time)
          end
          it 'changes the opened date but the challenge is still closed' do
            expect(@challenge.opened_at).to eq @time
            expect(@challenge.opened?).to be false
          end
        end
        context 'which represents the past datetime' do
          before do
            @current = Time.zone.now
            @time = @current.yesterday
            @opened_at = @challenge.open!(@time)
          end
          it 'opens the challenge immediately and sets to opened time to now' do
            expect(@challenge.opened_at).to eq @opened_at
            expect(@challenge.opened?).to be true
          end
        end
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
        expect(@challenge.opened?).to be true
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
        expect(@challenge.opened?).to be false
      end
    end
    context 'if the challenge is opened' do
      before do
        @challenge.open!
      end
      it 'closes the challenge' do
        @challenge.close!
        expect(@challenge.opened?).to be false
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

  describe '.opened' do
    subject { Challenge.opened }

    context 'when no challenges are registered' do
      it 'returns emtpy set' do
        expect(subject).to be_empty
      end
    end

    context 'when some challenges are registered' do
      before do
        Timecop.freeze do
          @opened_challenges = 3.times.map { create(:challenge) }
          @opened_challenges.each { |c| c.open! }
          @closed_challenges = create(:challenge)
          @future_challenges =
            create(:challenge, opened_at: Time.zone.now.tomorrow)
        end
      end

      it 'returns opened challenges' do
        expect(subject).to include(*@opened_challenges)
        expect(subject).not_to include(@closed_challenges)
        expect(subject).not_to include(@future_challenges)
      end
    end
  end

  describe '#first_break' do
    let(:challenge) { create(:challenge) }
    let(:player) do
      player = create(:player)
      player.confirm!
      player
    end

    subject { challenge.first_break }

    context 'when no players submit correct answers' do
      before do
        3.times.each do
          player.submit(challenge, '!WRONG_FLAG!')
        end
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when a player submits an correct answer' do
      before do
        3.times.each do
          player.submit(challenge, '!WRONG_FLAG!')
        end
        @answers = 3.times.map do
          player.submit(challenge, challenge.flags.first.flag)
        end
      end

      it 'returns the first answer' do
        expect(subject).to eq @answers.first
      end
    end
  end
end
