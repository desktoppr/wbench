require 'json'
require 'net/http'
require 'uri'
require 'capybara'

Capybara.register_driver(:selenium_chrome) { |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) }

module WBench
  class Benchmark
    def self.run(url, loops=25)
      new(url).run(loops)
    end

    def initialize(url)
      @url = url
    end

    def run(loops)
      @results = Results.new(@url, loops)

      loops.times { @results.add(browser_timing, app_response_time) }

      @results
    end

    private

    def app_response_time
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      (response.header['x-runtime'].to_f*1000).to_i
    end

    def browser_timing
      session = Capybara::Session.new(:selenium_chrome)
      session.visit @url
      session.has_css?('body')
      sleep 0.2

      timing_json = JSON.parse(session.evaluate_script('JSON.stringify(window.performance.timing)'))
      session.driver.browser.quit

      TimingHash.new(timing_json)
    end
  end
end
