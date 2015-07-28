describe WBench::Titleizer do
  describe '#to_s' do
    subject { described_class.new('dom loading time') }

    it 'outputs a title' do
      expect(subject.to_s).to eq('DOM Loading Time:')
    end
  end
end
