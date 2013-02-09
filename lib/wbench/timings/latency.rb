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

        # Here we'll need to inject some JavaScript into the DOM
        # See the latency.js file.
        #
        # JavaScript is a WIP!
      end
    end
  end
end
