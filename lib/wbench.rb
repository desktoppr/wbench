require 'json'
require 'net/http'
require 'uri'
require 'benchmark'
require 'delegate'
require 'colorize'
require 'capybara'
require 'selenium/webdriver'

require 'wbench/timings/app_server'
require 'wbench/timings/browser'
require 'wbench/timings/latency'
require 'wbench/benchmark'
require 'wbench/browser'
require 'wbench/results'
require 'wbench/results_formatter'
require 'wbench/row_formatter'
require 'wbench/stats'
require 'wbench/timing_hash'
require 'wbench/titleizer'
require 'wbench/version'

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
