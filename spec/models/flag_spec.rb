require 'spec_helper'

describe Flag, :type => :model do
  describe '#point=' do
    before do
      @flag = create(:flag)
    end
    context 'when attempt to set it to negative value' do
      it 'should not be changed' do
        old_point = @flag.point
        @flag.point = -100
        expect(@flag.point).to eq old_point
      end
    end

    context 'when attempt to set it to non-negative value' do
      it 'should be changed' do
        expect { @flag.point = 400 }.to change{@flag.point}
        expect { @flag.point = 0 }.to change{@flag.point}
      end
    end

    context 'when attempt to set it to not a number' do
      it 'fails with ArgumentError' do
        expect { @flag.point = 'abc' }.to raise_error ArgumentError
      end
    end
  end
end
