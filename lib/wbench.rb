require 'json'
require 'net/http'
require 'uri'
require 'rest-client'
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
require 'wbench/gist_writer'
require 'wbench/selenium_driver'
require 'wbench/results'
require 'wbench/results_formatter'
require 'wbench/row_formatter'
require 'wbench/stats'
require 'wbench/timing_hash'
require 'wbench/titleizer'
require 'wbench/version'

module WBench
  CAPYBARA_DRIVER  = :wbench_browser
  CAPYBARA_TIMEOUT = 60
  DEFAULT_LOOPS    = 10
  DEFAULT_BROWSER  = :chrome
end
