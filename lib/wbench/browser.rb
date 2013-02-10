module WBench
  class Browser
    attr_accessor :url

    def initialize(url)
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

      directory = File.expand_path(File.dirname(__FILE__))
      file = File.open(File.join(directory, 'wbench.js'))

      @script = file.read
    end
  end
end
