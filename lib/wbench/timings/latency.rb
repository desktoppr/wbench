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
        @session.evaluate_script('resourceURLs();')
      end

      private

      def wbench_javascript
        directory = File.expand_path(File.dirname(__FILE__))
        file = File.open(File.join(directory, 'latency.js'))

        file.read
      end
    end
  end
end
