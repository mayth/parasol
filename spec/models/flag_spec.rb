require 'spec_helper'

describe Flag do
  describe '#point=' do
    before do
      @flag = create(:flag)
    end
    context 'when attempt to set it to negative value' do
      it 'should not be changed' do
        expect { @flag.point = -100 }.not_to change{@flag.point}
      end
    end
    context 'when attempt to set it to non-negative value' do
      it 'should be changed' do
        expect { @flag.point = 400 }.to change{@flag.point}
        expect { @flag.point = 0 }.to change{@flag.point}
      end
    end
  end
end
