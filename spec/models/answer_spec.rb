require 'spec_helper'

describe Answer do
  describe '#correct?' do
    before do
      @challenge = build(:challenge, flags: [])
      @flags = [
        create(:flag, flag: 'FLAG_01234',  point: 100),
        create(:flag, flag: 'FLAG_56789',  point: 200),
        create(:flag, flag: '(?i)flAg_kogaSA', point: 300)
      ]
      @flags.each {|f| @challenge.flags << f}
      @challenge.save!
      @player = create(:player)
      @player.confirm!
    end
    context 'when it is the correct answer' do
      it 'returns true' do
        answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
        expect(answer.flag).to be_true
        answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
        expect(answer.flag).to be_true
        answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
        expect(answer.flag).to be_true
      end
    end
    context 'when it is the incorrect answer' do
      it 'returns false' do
        answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_mofmof')
        expect(answer.flag).to be_false
      end
    end
  end

  describe '#flag' do
    before do
      @challenge = build(:challenge, flags: [])
      @flags = [
        create(:flag, flag: 'FLAG_01234',  point: 100),
        create(:flag, flag: 'FLAG_56789',  point: 200),
        create(:flag, flag: '(?i)flAg_kogaSA', point: 300)
      ]
      @flags.each {|f| @challenge.flags << f}
      @challenge.save!
      @player = create(:player)
    end
    context 'when it is the correct answer' do
      it 'returns the flag' do
        answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
        expect(answer.flag).to eq @flags[0]
        answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
        expect(answer.flag).to eq @flags[1]
        answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
        expect(answer.flag).to eq @flags[2]
      end
    end
    context 'when it is the incorrect answer' do
      it 'returns nil' do
        wrong_flags =
        [
          'FLAG_mofmof',   # No such flag!
          "flAg_kogaSA\n", # No trailing line-breaks!
          'FlaG_01234'     # That flag is case-sensitive!
        ]
        wrong_flags.each do |answer|
          answer = create(
            :answer,
            player: @player, challenge: @challenge, answer: answer
          )
          expect(answer.flag).to be_nil
        end
      end
    end
  end

  describe '#valid_answer?' do
    before do
      @challenge = build(:challenge, flags: [])
      @flags = [
        create(:flag, flag: 'FLAG_01234',  point: 100),
        create(:flag, flag: 'FLAG_56789',  point: 200),
        create(:flag, flag: '(?i)flAg_kogaSA', point: 300)
      ]
      @flags.each { |f| @challenge.flags << f }
      @challenge.save!
      @player = create(:player)
      @player.confirm!
      @player2 = create(:player, team: @player.team)
      @player2.confirm!
    end

    context 'when it is the correct answer' do
      context 'and the player does not answer for it' do
        it 'returns true' do
          answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
          expect(answer.flag).to be_true
          answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
          expect(answer.flag).to be_true
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
          expect(answer.flag).to be_true
        end
      end

      context 'but the player already answered for it' do
        before do
          create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
          create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
          create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
        end

        it 'returns false' do
          answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
          expect(answer.valid_answer?).to be_false
        end
      end

      context 'but the team-mate already answered for it' do
        before do
          create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
          create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
          create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
        end

        it 'returns false' do
          answer = create(:answer, player: @player2, challenge: @challenge, answer: @flags[0].flag)
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player2, challenge: @challenge, answer: @flags[1].flag)
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player2, challenge: @challenge, answer: 'FLAG_KOGASA')
          expect(answer.valid_answer?).to be_false
        end
      end
    end

    context 'when it is the wrong answer' do
      context 'and the player does not answer for it' do
        it 'returns false' do
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'WRONG_FLAG!')
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'WRONG_FLAG?')
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_MARISA')
          expect(answer.valid_answer?).to be_false
        end
      end

      context 'and the player already answered for it' do
        before do
          create(:answer, player: @player, challenge: @challenge, answer: @flags[0].flag)
          create(:answer, player: @player, challenge: @challenge, answer: @flags[1].flag)
          create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_KOGASA')
        end

        it 'returns false' do
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'WRONG_FLAG!')
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'WRONG_FLAG?')
          expect(answer.valid_answer?).to be_false
          answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_MARISA')
          expect(answer.valid_answer?).to be_false
        end
      end
    end

  end
end
