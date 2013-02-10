module WBench
  module Timings
    class Browser
      def initialize(browser)
        @browser = browser
      end

      def result
        timing_json = @browser.evaluate_script('window.performance.timing')

        TimingHash.new(timing_json)
      end
    end
  end
end
