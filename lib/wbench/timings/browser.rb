module WBench
  module Timings
    class Browser
      def initialize(browser)
        @browser = browser
      end

      def result
        TimingHash.new(timing_json)
      end

      private

      def timing_json
        @browser.evaluate_script('WBench.performanceTimings()')
      end
    end
  end
end
