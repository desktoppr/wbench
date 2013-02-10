module WBench
  module Timings
    class Latency
      def initialize(url)
        @url = url
        @session = Capybara::Session.new(CAPYBARA_DRIVER)
      end

      def result
        @session.visit @url
        @session.has_css?('body')
        sleep 0.2

        @session.execute_script(wbench_javascript)

        Hash[domains.map { |domain| [domain, latency_for(domain) ] }.sort]
      end

      private

      def latency_for(domain)
        (::Benchmark.measure { TCPSocket.new(domain, 80) }.real * 1000).to_i
      end

      def wbench_javascript
        directory = File.expand_path(File.dirname(__FILE__))
        file = File.open(File.join(directory, 'latency.js'))

        file.read
      end

      def domains
        @domains ||= JSON.parse(@session.evaluate_script('JSON.stringify(resourceURLs())')).map do |url|
          URI(url).host
        end.uniq
      end
    end
  end
end
