require 'spec_helper'

describe Player do
  describe '#submit' do
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
      it 'returns the flag' do
        expect(@player.submit(@challenge, @flags[0].flag)).to eq @flags[0]
        expect(@player.submit(@challenge, @flags[1].flag)).to eq @flags[1]
      end
    end
    context 'when it is the incorrect answer' do
      it 'returns nil' do
        expect(@player.submit(@challenge, 'FLAG_piyopiyo')).to be_nil
      end
    end
  end

  describe '#point' do
    before do
      @challenges = 3.times.map {create(:challenge)}
    end
    subject { @player.point }
    context 'when the player correctly answered some challenges' do
      before do
        @player = create(:player)
        @player.submit(@challenges[0], @challenges[0].flags[0].flag)
        @player.submit(@challenges[1], @challenges[1].flags[0].flag)
      end
      it 'returns summation of the correctly answered challenges points' do
        expect(subject).to eq 0.upto(1).map{|n| @challenges[n].flags[0].point}.inject(:+)
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
    context 'when the player has answered but they are wrong' do
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
end
