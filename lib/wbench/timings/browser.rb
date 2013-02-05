module WBench
  module Timings
    class Browser
      def initialize(url)
        @url = url
        @session = Capybara::Session.new(CAPYBARA_DRIVER)
      end

      def result
        @session.visit @url
        @session.has_css?('body')
        sleep 0.2

        timing_json = JSON.parse(@session.evaluate_script('JSON.stringify(window.performance.timing)'))
        @session.driver.browser.quit

        TimingHash.new(timing_json)
      end
    end
  end
end
