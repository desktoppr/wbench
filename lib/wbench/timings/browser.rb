module WBench
  module Timings
    class Browser
      def initialize(browser)
        @browser = browser
      end

      def result
        timing_json = JSON.parse(@browser.evaluate_script('JSON.stringify(window.performance.timing)'))

        TimingHash.new(timing_json)
      end
    end
  end
end
