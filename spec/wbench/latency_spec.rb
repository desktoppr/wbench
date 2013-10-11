describe WBench::Timings::Latency do
  subject(:latency) { described_class.new(browser) }
  let(:browser) { double 'browser' }
  let(:resource_urls) do
    JSON.dump([
      "http://3.example.com/path",
      "https://1.example.com/path",
      "http://2.example.com:3000/path",
    ])
  end

  before do
    allow(browser).to receive(:evaluate_script).with('WBench.resourceURLs()') { resource_urls }
    allow(::Benchmark).to receive(:measure).and_yield.and_return(30, 10, 20)
  end

  describe "#result" do
    shared_examples_for "result" do
      it "measures latency for every host" do
        expect(::Benchmark).to receive(:measure).and_yield.and_return(30, 10, 20)
        expect(::TCPSocket).to receive(:new).with("1.example.com", 443)
        expect(::TCPSocket).to receive(:new).with("2.example.com", 3000)
        expect(::TCPSocket).to receive(:new).with("3.example.com", 80)
        latency.result
      end

      it "returns a hash of the measurement results, sorted by hostname" do
        expect(latency.result).to eq expected_result
      end
    end

    context "when no SocketError" do
      before do
        allow(::TCPSocket).to receive(:new)
      end

      let(:expected_result) do
        {
          "1.example.com:443" => 10000,
          "2.example.com:3000" => 20000,
          "3.example.com:80" => 30000,
        }
      end

      it_behaves_like "result"
    end

    context "on SocketError" do
      before do
        allow(TCPSocket).to receive(:new).and_raise(SocketError.new)
      end

      let(:expected_result) do
        {
          "1.example.com:443" => nil,
          "2.example.com:3000" => nil,
          "3.example.com:80" => nil,
        }
      end

      it_behaves_like "result"
    end
  end
end
