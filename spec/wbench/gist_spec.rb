require 'spec_helper'

describe WBench::GistWriter do
  describe '#write' do
    it 'should prepare json for writing gist' do
      @gist_results = {name: "wbench_results", secret: false}
      expected_response = {description: "WBench Results", public: true, files: {"wbench_results.txt" => {content: "results"}}}.to_json
      gw = WBench::GistWriter.new(@gist_results)
      gw.json_request("results").to_json().should == expected_response
    end
    
    it 'should create gist' do
      @gist_results = {name: "wbench_results", secret: false}
      WBench::GistWriter.write_gist("results", @gist_results)
    end
  end
end