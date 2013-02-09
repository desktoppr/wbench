require 'colorize'
require 'json'
require 'net/http'
require 'uri'
require 'capybara'

require 'wbench/version'
require 'wbench/benchmark'
require 'wbench/results'
require 'wbench/timing_hash'
require 'wbench/row_formatter'
require 'wbench/timings/app'
require 'wbench/timings/browser'

module WBench
  CAPYBARA_DRIVER = :wbench_browser
  DEFAULT_LOOPS = 10

  Capybara.register_driver(CAPYBARA_DRIVER) do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
end
