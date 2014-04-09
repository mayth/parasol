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

  describe '#flag_point' do
    before do
      @challenges = 3.times.map { create(:challenge) }
    end
    subject { @player.flag_point }
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

  describe '#point' do
    let(:player) do
      player = create(:player)
      player.confirm!
      player
    end

    subject { player.point }

    context 'with the player who has flag point but no adjustments' do
      before do
        challenge = create(
          :challenge,
          flags: [create(:flag, point: 300)]
        )
        player.submit(challenge, challenge.flags.first.flag)
      end

      it 'returns same as #flag_point' do
        expect(subject).to eq player.flag_point
        expect(subject).to eq 300
      end
    end

    context 'with the player who has adjustment point but has no flag point' do
      before do
        player.adjust!(200)
      end

      it 'returns same as #adjustment_point' do
        expect(subject).to eq player.adjustment_point
        expect(subject).to eq 200
      end
    end

    context 'with the player who has flag point and also adjustment point' do
      before do
        challenge = create(
          :challenge,
          flags: [create(:flag, point: 300)]
        )
        player.submit(challenge, challenge.flags.first.flag)
        player.adjust!(200)
      end

      it 'returns summation of flag point and adjustment point' do
        expect(subject).to eq player.flag_point + player.adjustment_point
        expect(subject).to eq 500
      end
    end
  end

  describe '#last_submission' do
    let(:player) do
      p = create(:player)
      p.confirm!
      p
    end
    let(:challenge) { create(:challenge) }

    describe 'with valid_only' do
      subject { player.last_submission(valid_only: true) }

      context 'if the player submits some answers' do
        context 'and submitted answers contains a valid one at least one' do
          before do
            @submissions = 3.times.map do
              player.answers.create(
                challenge: challenge,
                answer: challenge.flags[0].flag)
            end
            @submissions << player.answers.create(
              challenge: challenge,
              answer: challenge.flags[1].flag)
          end

          it 'returns the last valid submission' do
            expect(subject).to eq @submissions.last
          end
        end

        context 'and all submitted answers are wrong' do
          before do
            @submissions = 3.times.map do
              player.answers.create(
                challenge: challenge,
                answer: '!WRONG_FLAG!')
            end
          end

          it 'returns nil' do
            expect(subject).to be_nil
          end
        end
      end

      context 'if the player does not submit any answers yet' do
        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
    end

    describe 'without valid_only' do
      subject { player.last_submission(valid_only: false) }

      context 'if the player submits some answers' do
        before do
          @submissions = 3.times.map do
            player.answers.create(
              challenge: challenge,
              answer: challenge.flags[0].flag)
          end
        end

        it 'returns the last submission' do
          expect(subject).to eq @submissions.last
        end
      end

      context 'if the player does not submit any answers yet' do
        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
    end
  end
end
