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
          if browser == :firefox
            profile = Selenium::WebDriver::Firefox::Profile.new
            profile['general.useragent.override'] = options[:user_agent]
            selenium_options[:profile] = profile
          else
            add_selenium_args(selenium_options, "--user-agent='#{options[:user_agent]}'")
          end
        end

        add_selenium_args(selenium_options, "--enable-precise-memory-info")
        SeleniumDriver.new(app, selenium_options)
      end

      @url           = Addressable::URI.parse(url).normalize.to_s
      @cookie_string = options[:cookie]
    end

    def visit
      set_cookies
      session.visit(@url)
      wait_for_page
    end

    def done
      session.execute_script(wbench_javascript)
      yield if block_given?
      close
    end

    def evaluate_script(script)
      session.evaluate_script(script)
    end

    def run(&blk)
      session.instance_eval(&blk) if block_given?
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
      wbench    = File.open(File.join(directory, 'wbench.js'))
      @script   = wbench.read
    end

    def wait_for_page
      Selenium::WebDriver::Wait.new(:timeout => CAPYBARA_TIMEOUT).until do
        session.evaluate_script('window.performance.timing.loadEventEnd').to_i > 0
      end
    end

    def set_cookies
      WBench::Cookies.set(session, url, @cookie_string)
    end
  end
end
