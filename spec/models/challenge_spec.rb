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
end
