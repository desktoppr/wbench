module WBench
  module Timings
    class Latency
      def initialize(browser)
        @browser = browser
      end

      def result
        Hash[domains.map { |domain| [domain, latency_for(domain) ] }.sort]
      end

      private

      def latency_for(domain)
        (::Benchmark.measure { TCPSocket.new(domain, 80) }.real * 1000).to_i
      rescue SocketError
        nil
      end

      def domains
        @domains ||= JSON.parse(@browser.evaluate_script('JSON.stringify(resourceURLs())')).map do |url|
          URI(url).host
        end.compact.uniq
      end
    end
  end
end
