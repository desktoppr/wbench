require 'colorize'
require 'json'
require 'net/http'
require 'uri'
require 'capybara'
require 'selenium/webdriver'

require 'wbench/version'
require 'wbench/benchmark'
require 'wbench/results'
require 'wbench/timing_hash'
require 'wbench/row_formatter'
require 'wbench/timings/app'
require 'wbench/timings/browser'
require 'wbench/timings/latency'

module WBench
  CAPYBARA_DRIVER  = :wbench_browser
  DEFAULT_LOOPS    = 10
  CAPYBARA_TIMEOUT = 10

  Capybara.register_driver(CAPYBARA_DRIVER) do |app|
    http_client = Selenium::WebDriver::Remote::Http::Default.new
    http_client.timeout = CAPYBARA_TIMEOUT

    Capybara::Selenium::Driver.new(app, :browser => :chrome, :http_client => http_client)
  end
end
