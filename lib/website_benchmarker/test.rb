require 'capybara'

module WebsiteBenchmarker
  class Test
    extend Capybara::DSL

    Capybara.register_driver(:selenium_chrome) { |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) }
    Capybara.current_driver = :selenium_chrome

    def self.run(url, loops=8)
      @results = Results.new

      loops.times do
        Capybara.reset_sessions!

        visit url
        page.has_css?('body')
        sleep 0.25

        timing_json = JSON.parse(page.evaluate_script('JSON.stringify(window.performance.timing)'))
        timing = TimingHash.new(timing_json)

        @results.add(timing)
      end

      puts @results
    end
  end
end
