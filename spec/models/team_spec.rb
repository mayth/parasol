require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '#forget_password!' do
    before do
      @old_pw = 'test'
      @team = create(:team, password: @old_pw, password_confirmation: @old_pw)
      @new_pw = @team.forget_password!
    end
    it 'returns the new password' do
      expect(@old_pw).not_to eq @new_pw
    end
    it 'successfully authenticate with the new password' do
      expect(@team.authenticate(@new_pw)).to eq @team
    end
  end

  describe '#suspended?' do
    before do
      @team = create(:team)
    end
    context 'if the team is not suspended' do
      it 'returns false' do
        expect(@team.suspended?).to be false
      end
    end
    context 'if the team is suspended' do
      before do
        @team.suspend!
      end
      it 'returns true' do
        expect(@team.suspended?).to be true
      end
    end
  end

  describe '#suspend!' do
    before do
      @team = create(:team)
      @suspend_until = Time.now.tomorrow
    end
    context 'if the team is not suspended' do
      before do
        @team.suspend!(@suspend_until)
      end
      it 'suspends the team' do
        expect(@team.suspended?).to be true
        expect(@team.suspended_until).to eq @suspend_until
      end
    end
  end

  describe '#resume!' do
    before do
      @team = create(:team)
    end
    context 'if the team is not suspended' do
      it 'does nothing' do
        @team.resume!
        expect(@team.suspended?).to be false
      end
    end
    context 'if the team is suspended' do
      before do
        @team.suspend!
      end
      it 'resumes the team' do
        @team.resume!
        expect(@team.suspended?).to be false
      end
    end
  end

  describe '#point' do
    subject { @team.point }
    context 'if the team has no members' do
      before do
        @team = create(:team, players: [])
      end
      it 'returns 0' do
        expect(subject).to eq 0
      end
    end
    context 'if the team has some members' do
      before do
        @team = create(:team, players: [])
        @players = 2.times.map {create(:player)}
        @players.each {|p| @team.players << p}
        challenge = create(:challenge)
        @players[0].submit(challenge, challenge.flags[0].flag)

        challenge = build(:challenge, flags: [])
        f = challenge.flags.build(flag: 'FLAG_abcde', point: 300)
        challenge.save!
        f.save!
        @players[1].submit(challenge, challenge.flags[0].flag)
      end
      it "returns summation of the players' point" do
        expect(subject).to eq @players.map{|p| p.point}.inject(:+)
      end
    end
  end

  describe '#flag_point' do
    let(:team) { create(:team) }
    let(:challenge) do
      points = [100, 200, 400]
      create(:challenge, flags: points.map { |p| create(:flag, point: p) })
    end

    subject { team.flag_point }

    describe 'with the team that has no members' do
      before do
        team.players.clear
      end

      it 'returns 0' do
        expect(subject).to eq 0
      end
    end

    describe 'with the team that has some members' do
      before do
        3.times.each do
          player = create(:player)
          player.confirm
          team.players << player
        end
      end

      context 'if the team members submits some valid flags' do
        before do
          team.players[0].submit(challenge, challenge.flags[0].flag)
          team.players[1].submit(challenge, challenge.flags[1].flag)
        end
        it "returns the summation of members' flag point" do
          expect(subject).to eq 300 # flag[0] + flag[1]
        end
      end

      context 'if the team members do not submit any valid flags' do
        before do
          team.players[0].submit(challenge, '!WRONG_FLAG!')
          team.players[1].submit(challenge, '!WRONG_FLAG_2!')
        end
        it 'returns 0' do
          expect(subject).to eq 0
        end
      end
    end
  end

  describe '#adjustment_point' do
    subject { @team.adjustment_point }
    context 'if the team has no members' do
      before do
        @team = create(:team, players: [])
      end
      it 'returns 0' do
        expect(subject).to eq 0
      end
    end
    context 'if the team has some members' do
      before do
        @players = 2.times.map { create(:player) }
        @team = create(:team, players: @players)
        @players.each.with_index { |p, n| p.adjust!(n * 100) }
      end
      it "returns summation of the players' point" do
        expect(subject)
          .to eq @players.map { |p| p.adjustment_point }.inject(:+)
      end
    end
  end

  describe '#member?' do
    before do
      @team = create(:team)
      @player = create(:player)
    end
    subject { @team.member?(@player) }

    context 'when the player belongs to the team' do
      before do
        @player.team = @team
        @player.save
      end

      it 'returns true' do
        expect(subject).to be true
      end
    end

    context 'when the player does not belong to the team' do
      before do
        @player.team = create(:team)
        @player.save
      end

      it 'returns false' do
        expect(subject).to be false
      end
    end
  end

  describe '#last_submission' do
    let(:team) do
      p = create(:player)
      p.confirm
      create(:team, players: [p])
    end
    let(:challenge) { create(:challenge) }

    describe 'with valid_only' do
      subject { team.last_submission(valid_only: true) }

      describe 'with the team that has no members' do
        before do
          team.players.clear
        end

        it 'returns nil' do
          expect(subject).to be_nil
        end
      end

      describe 'with the team that has some members' do
        context 'if a one of the team member submits some answers' do
          context 'and these answers contains a valid one at least one' do
            before do
              player = team.players.first
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

          context 'and all of these answers are wrong' do
            before do
              player = team.players.first
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
      end
    end

    describe 'without valid_only' do
      subject { team.last_submission(valid_only: false) }

      describe 'with the team that has no members' do
        before do
          team.players.clear
        end

        it 'returns nil' do
          expect(subject).to be_nil
        end
      end

      describe 'with the team that has some members' do
        context 'if a one of the team member submits some answers' do
          before do
            player = team.players.first
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

        context 'if anyone in the team does not submit any answers' do
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end
      end
    end
  end

  describe '.ranking' do
    subject { Team.ranking }
    context 'with teams that has no points nor submissions' do
      it 'returns teams in acending order of team registration date' do
        teams = 3.times.map { create(:team) }
        3.times.each do |i|
          expect(subject[i]).to eq teams[i]
        end
      end
    end

    context 'with some teams and their point differ each other' do
      it 'returns teams in descending order of the team point' do
        challenge = create(
          :challenge,
          flags: 5.times.map { |n| create(:flag) })
        teams = 5.times.map do |i|
          team = create(:team)
          player = create(:player, team: team)
          i.times.each do |n|
            player.submit(challenge, challenge.flags[n].flag)
          end
          team
        end
        teams.reverse!
        (0..4).each do |i|
          expect(subject[i]).to eq teams[i]
        end
      end
    end

    context 'with some teams that has the same point' do
      it 'returns teams in ascending order of last submission date' do
        challenge = create(
          :challenge,
          flags: 5.times.map { |n| create(:flag) })
        teams = 5.times.map do
          team = create(:team)
          player = create(:player, team: team)
          player.submit(challenge, challenge.flags.first.flag)
          team
        end
        (0..4).each do |i|
          expect(subject[i]).to eq teams[i]
        end
      end
    end
  end
end
