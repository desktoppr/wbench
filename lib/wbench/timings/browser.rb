module WBench
  module Timings
    class Browser
      def initialize(browser)
        @browser = browser
      end

      def result
        {
          timing: TimingHash.new(timing_json),
          memory: MemoryHash.new(memory_json)
        }
      end

      private

      def timing_json
        @browser.evaluate_script('WBench.performanceTimings()')
      end

      def memory_json
        @browser.evaluate_script('WBench.performanceMemory()')
      end
    end
  end
end
