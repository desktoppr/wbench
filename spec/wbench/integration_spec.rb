require 'spec_helper'

require File.expand_path(File.dirname(__FILE__)) + '/../support/test_sites'

describe 'wbench' do
  sites.each_with_index do |site, index|
    if index == 0
      it 'accepts a user agent string' do
        expect { WBench::Benchmark.run(sites.first, :loops => 1, :user_agent => 'a mobile browser') }.to_not raise_exception
      end
    end

    it "should return information from #{site} in chrome" do
      expect { WBench::Benchmark.run(site, :loops => 1) }.to_not raise_exception
    end

    it "should return information from #{site} in firefox" do
      expect { WBench::Benchmark.run(site, :browser => :firefox, :loops => 1) }.to_not raise_exception
    end
  end
end
