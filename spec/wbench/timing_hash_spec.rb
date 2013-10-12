describe WBench::TimingHash do
  describe '#new' do
    let(:timings) { { :end => 20, :middle => 15, :start => 10, :nope => 0 } }
    subject { described_class.new(timings) }

    it 'removes keys with a value of 0' do
      subject.should_not have_key :nope
    end

    it 'offsets each value by the starting(lowest) value' do
      subject[:start].should == 0
      subject[:middle].should == 5
      subject[:end].should == 10
    end

    it 'orders the hash by value, lowest first' do
      subject.first.should == [:start, 0]
    end
  end
end
