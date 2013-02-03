require 'capybara'

module WBench
  class Benchmark
    extend Capybara::DSL

    Capybara.register_driver(:selenium_chrome) { |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) }
    Capybara.current_driver = :selenium_chrome

    def self.run(url, loops=25)
      @results = Results.new(url, loops)

      loops.times do
        Capybara.reset_sessions!

        visit url
        page.has_css?('body')
        sleep 0.25

        timing_json = JSON.parse(page.evaluate_script('JSON.stringify(window.performance.timing)'))
        timing = TimingHash.new(timing_json)

        @results.add(timing)
      end

      @results
    end
  end
end
