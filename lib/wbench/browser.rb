module WBench
  class Browser
    attr_accessor :url

    def initialize(url, options = {})
      browser = options[:browser] || DEFAULT_BROWSER
      ua      = options[:ua]

      Capybara.register_driver(CAPYBARA_DRIVER) do |app|
        http_client = Selenium::WebDriver::Remote::Http::Default.new
        http_client.timeout = CAPYBARA_TIMEOUT

        opts = { :browser => browser.to_sym, :http_client => http_client }
        opts[:args] = ["--user-agent='#{ua}'"] if ua

        SeleniumDriver.new(app, opts)
      end

      @url = url
    end

    def visit
      session.visit(@url)
      session.has_css?('body')
      session.execute_script(wbench_javascript)

      yield if block_given?

      close
    end

    def evaluate_script(script)
      session.evaluate_script(script)
    end

    private

    def session
      @session ||= Capybara::Session.new(CAPYBARA_DRIVER)
    end

    def close
      session.driver.browser.quit
      @session = nil
    end

    def wbench_javascript
      return @script if @script

      directory = File.expand_path(File.dirname(__FILE__)) + '/../javascripts'
      jquery    = File.open(File.join(directory, 'jquery.1.9.1.min.js'))
      stringify = File.open(File.join(directory, 'jquery.stringify.js'))
      wbench    = File.open(File.join(directory, 'wbench.js'))

      @script = jquery.read + stringify.read + wbench.read
    end
  end
end
