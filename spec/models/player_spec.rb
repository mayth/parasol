require 'spec_helper'

describe Player do
  describe '#submit' do
    before do
      @challenge = build(:challenge, flags: [])
      @flags = [
        create(:flag, flag: 'FLAG_01234',  point: 100),
        create(:flag, flag: 'FLAG_56789',  point: 200),
        create(:flag, flag: 'FLAG_KOGASA', point: 300)
      ]
      @flags.each { |f| @challenge.flags << f }
      @challenge.save!
      @player = create(:player)
      @player.confirm!
    end

    context 'when it is the correct answer' do
      it 'returns the flag' do
        expect(@player.submit(@challenge, @flags[0].flag)).to eq @flags[0]
        expect(@player.submit(@challenge, @flags[1].flag)).to eq @flags[1]
      end

      it "adds the flag point to the player's point" do
        expect { @player.submit(@challenge, @flags[2].flag) }
          .to change { @player.point }.by(@flags[2].point)
      end
    end

    context 'when it is the wrong answer' do
      it 'returns nil' do
        expect(@player.submit(@challenge, 'FLAG_piyopiyo')).to be_nil
      end

      it "does not change the player's point" do
        expect { @player.submit(@challenge, 'FLAG_piyopiyo') }
          .not_to change { @player.point }
      end
    end

    context 'when it is the correct answer but already answered' do
      before do
        expect(@player.submit(@challenge, @flags[0].flag)).to eq @flags[0]
      end

      it 'returns the flag' do
        expect(@player.submit(@challenge, @flags[0].flag)).to eq @flags[0]
      end

      it "does not change the player's point" do
        expect { @player.submit(@challenge, @flags[0].flag) }
          .not_to change { @player.point }
      end
    end
  end

  describe '#point' do
    before do
      @challenges = 3.times.map { create(:challenge) }
    end
    subject { @player.point }
    context 'when the player answered some challenges' do
      context 'with the correct flag' do
        before do
          @player = create(:player)
          @player.submit(@challenges[0], @challenges[0].flags[0].flag)
          @player.submit(@challenges[1], @challenges[1].flags[0].flag)
          @player.submit(@challenges[0], 'WRONG_FLAG')  # Wrong Answer
        end
        it 'returns summation of the correctly answered challenges points' do
          expect(subject)
            .to eq 0.upto(1).map { |n| @challenges[n].flags[0].point }.inject(:+)
        end
      end

      context 'with the wrong flag' do
        before do
          @player = create(:player)
          @player.submit(@challenges[0], 'FLAG_mofmof')
          @player.submit(@challenges[1], 'FLAG_piyopiyo')
        end
        it 'returns 0' do
          expect(subject).to eq 0
        end
      end
    end

    context 'when the player does not answer any challenges' do
      before do
        @player = create(:player)
      end
      it 'returns 0' do
        expect(subject).to eq 0
      end
    end
  end

  describe 'member_of?' do
    before do
      @team = create(:team)
      @player = create(:player, team: @team)
    end
    subject { @player.member_of?(@team) }

    context 'when the player belongs to the given team' do
      it 'returns true' do
        expect(subject).to be_true
      end
    end

    context 'when the player does not belong to the given team' do
      before do
        @player.team = create(:team)
        @player.save
      end

      it 'returns false' do
        expect(subject).to be_false
      end
    end
  end

  describe '#adjust!' do
    let(:player) do
      p = create(:player)
      p.confirm!
      p
    end

    context 'with valid parameters' do
      it 'changes the adjustment point' do
        expect { player.adjust!(100) }
          .to change { player.adjustment_point }.by(100)
      end

      it "changes the player's point" do
        expect { player.adjust!(100) }
          .to change { player.point }.by(100)
      end
    end

    context 'with invalid parameters' do
      it 'does not change the adjustment point' do
        expect { player.adjust!(4.2) }
          .not_to change { player.adjustment_point }
      end

      it "does not change the player's point" do
        expect { player.adjust!(4.2) }
          .not_to change { player.point }
      end
    end
  end

  describe '#adjustment_point' do
    let(:player) do
      p = create(:player)
      p.confirm!
      p
    end

    before do
      ch = create(:challenge)
      @flag_point = ch.flags[0].point
      player.submit(ch, ch.flags[0].flag)
    end

    subject { player.adjustment_point }
    context 'when the player has no adjustments' do
      it 'returns 0' do
        expect(subject).to eq 0
      end

      it 'has no effects to the total point' do
        expect(player.point).to eq @flag_point
      end
    end

    context 'when the player has some adjustments' do
      before do
        @adjusts = 3.times.map { rand(-500..500) }
        @adjusts.each { |v| player.adjust!(v) }
      end

      it 'returns the sum of the adjustments' do
        expect(subject).to eq @adjusts.reduce(:+)
      end

      it 'has effects to the total point' do
        expect(player.point).to eq @flag_point + @adjusts.reduce(:+)
      end
    end
  end
end
