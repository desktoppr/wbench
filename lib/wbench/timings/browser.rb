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
        @browser.evaluate_script('window.performance.timing')
      end
    end
  end
end
