require 'json'
require 'net/http'
require 'uri'
require 'capybara'

module WBench
  class Benchmark
    include Capybara::DSL

    Capybara.register_driver(:selenium_chrome) { |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) }
    Capybara.current_driver = :selenium_chrome

    def self.run(url, loops=25)
      new(url).run(loops)
    end

    def initialize(url)
      @url = url
    end

    def run(loops)
      @results = Results.new(@url, loops)

      loops.times do
        Capybara.reset_sessions!

        @results.add(browser_timing, app_response_time)
      end

      @results
    end

    private

    def visit_page
      visit @url
      page.has_css?('body')
      sleep 0.2
    end

    def app_response_time
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      (response.header['x-runtime'].to_f*1000).to_i
    end

    def browser_timing
      visit_page

      timing_json = JSON.parse(page.evaluate_script('JSON.stringify(window.performance.timing)'))

      TimingHash.new(timing_json)
    end
  end
end
