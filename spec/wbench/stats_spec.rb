require 'spec_helper'

describe WBench::Stats do
  describe '#median' do
    context 'when there are an odd number of results' do
      subject(:stats) { described_class.new([1,6,2,8,3]) }

      it 'returns the middle result' do
        stats.median.should == 3
      end
    end

    context 'when there an an event number of results' do
      subject(:stats) { described_class.new([1,6,2,8,3,9]) }

      it 'returns the higher of the two middle values' do
        stats.median.should == 6
      end
    end
  end

  describe '#sum' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    its(:sum) { should == 40 } # see: http://en.wikipedia.org/wiki/Standard_deviation
  end

  describe '#mean' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    its(:mean) { should == 5 } # see: http://en.wikipedia.org/wiki/Standard_deviation
  end

  describe '#sample_variance' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    its(:sample_variance) { should == 4 } # see: http://en.wikipedia.org/wiki/Standard_deviation
  end

  describe '#std_dev' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    its(:std_dev) { should == 2 } # see: http://en.wikipedia.org/wiki/Standard_deviation
  end
end
