describe WBench::TimingHash do
  describe '#new' do
    let(:timings) { { :end => 20, :middle => 15, :start => 10, :nope => 0 } }
    subject { described_class.new(timings) }

    it 'removes keys with a value of 0' do
      expect(subject).not_to have_key :nope
    end

    it 'offsets each value by the starting(lowest) value' do
      expect(subject[:start]).to eq(0)
      expect(subject[:middle]).to eq(5)
      expect(subject[:end]).to eq(10)
    end

    it 'orders the hash by value, lowest first' do
      expect(subject.first).to eq([:start, 0])
    end
  end
end
