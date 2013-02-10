require 'spec_helper'

describe WBench::Titleizer do
  describe '#to_s' do
    subject { described_class.new('dom loading time') }

    it 'outputs a title' do
      subject.to_s.should == 'DOM Loading Time:'
    end
  end
end
