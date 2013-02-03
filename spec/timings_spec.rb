require 'spec_helper'

describe WBench do
  describe '#add' do
    let(:timing) { Timing.new(data) }
    let(:data)   { JSON.parse('{"loadEventEnd":1359854901824,"loadEventStart":1359854901820,"domComplete":1359854901820,"domContentLoadedEventEnd":1359854893376,"domContentLoadedEventStart":1359854893376,"domInteractive":1359854893376,"domLoading":1359854890140,"responseEnd":1359854893372,"responseStart":1359854890128,"requestStart":1359854889943,"secureConnectionStart":0,"connectEnd":1359854889940,"connectStart":1359854889940,"domainLookupEnd":1359854889940,"domainLookupStart":1359854889940,"fetchStart":1359854889940,"redirectEnd":0,"redirectStart":0,"unloadEventEnd":0,"unloadEventStart":0,"navigationStart":1359854889322}') }

    it 'adds a new timing' do

    end
  end
end

