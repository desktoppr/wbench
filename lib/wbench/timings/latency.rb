module WBench
  module Timings
    class Latency
      def initialize(browser)
        @browser = browser
      end

      def result
        Hash[hosts.map { |host| [host.join(":"), latency_for(*host) ] }.sort]
      end

      private

      def latency_for(hostname, port)
        (::Benchmark.measure { TCPSocket.new(hostname, port) }.real * 1000).to_i
      rescue SocketError
        nil
      end

      def hosts
        @hosts ||= JSON.parse(@browser.evaluate_script('WBench.resourceURLs()')).map do |url|
          u = Addressable::URI.parse(url)
          [u.host, u.inferred_port]
        end.compact.uniq
      end
    end
  end
end
