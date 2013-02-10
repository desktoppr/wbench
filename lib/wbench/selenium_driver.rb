module WBench
  class SeleniumDriver < Capybara::Selenium::Driver
    private

    def at_exit
      # We have already quit the browser, so we do not want to try and close it
      # again here, so instead we do nothing.
    end
  end
end
