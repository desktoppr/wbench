describe WBench::Stats do
  describe '#median' do
    context 'when there are an odd number of results' do
      subject(:stats) { described_class.new([1,6,2,8,3]) }

      it 'returns the middle result' do
        expect(stats.median).to eq(3)
      end
    end

    context 'when there an an event number of results' do
      subject(:stats) { described_class.new([1,6,2,8,3,9]) }

      it 'returns the higher of the two middle values' do
        expect(stats.median).to eq(6)
      end
    end
  end

  describe '#sum' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    describe '#sum' do
      subject { super().sum }
      it { is_expected.to eq(40) }
    end # see: http://en.wikipedia.org/wiki/Standard_deviation
  end

  describe '#mean' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    describe '#mean' do
      subject { super().mean }
      it { is_expected.to eq(5) }
    end # see: http://en.wikipedia.org/wiki/Standard_deviation
  end

  describe '#sample_variance' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    describe '#sample_variance' do
      subject { super().sample_variance }
      it { is_expected.to eq(4) }
    end # see: http://en.wikipedia.org/wiki/Standard_deviation
  end

  describe '#std_dev' do
    subject(:stats) { described_class.new([2,4,4,4,5,5,7,9]) }

    describe '#std_dev' do
      subject { super().std_dev }
      it { is_expected.to eq(2) }
    end # see: http://en.wikipedia.org/wiki/Standard_deviation
  end
end
