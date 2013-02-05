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

module WBench
  DRIVER = :wbench_browser
  DEFAULT_LOOPS = 25

  Capybara.register_driver(DRIVER) do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
end
