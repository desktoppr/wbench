module WBench
  class Browser
    attr_accessor :url

    def initialize(url, options = {})

      Capybara.register_driver(CAPYBARA_DRIVER) do |app|
        http_client         = Selenium::WebDriver::Remote::Http::Default.new
        http_client.timeout = CAPYBARA_TIMEOUT
        browser             = (options[:browser] || DEFAULT_BROWSER).to_sym
        selenium_options    = { :browser => browser, :http_client => http_client }

        if options[:user_agent]
          add_selenium_args(selenium_options, "--user-agent='#{options[:user_agent]}'")
        end

        SeleniumDriver.new(app, selenium_options)
      end

      @url = Addressable::URI.parse(url).normalize.to_s
    end

    def visit
      session.visit(@url)
      wait_for_page
      session.execute_script(wbench_javascript)
      yield if block_given?
      close
    end

    def evaluate_script(script)
      session.evaluate_script(script)
    end

    private

    def add_selenium_args(options, arg)
      options[:args] ||= [ ]
      options[:args] << arg
    end

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

    def wait_for_page
      Selenium::WebDriver::Wait.new(:timeout => CAPYBARA_TIMEOUT).until do
        session.evaluate_script('document.readyState') == 'complete'
      end
    end
  end
end
