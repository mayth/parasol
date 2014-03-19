require 'spec_helper'

describe Answer do
  describe '#correct?' do
    before do
      @challenge = build(:challenge, flags: [])
      @flags = [
        create(:flag, flag: 'FLAG_01234', point: 100),
        create(:flag, flag: 'FLAG_56789', point: 200)
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
        create(:flag, flag: 'FLAG_01234', point: 100),
        create(:flag, flag: 'FLAG_56789', point: 200)
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
      end
    end
    context 'when it is the incorrect answer' do
      it 'returns nil' do
        answer = create(:answer, player: @player, challenge: @challenge, answer: 'FLAG_mofmof')
        expect(answer.flag).to be_nil
      end
    end
  end
end
