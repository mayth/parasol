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
end
