module WBench
  class Results
    def initialize(url, loops)
      @url         = url
      @loops      = loops
      @time       = Time.now.asctime
      @browser    = {}
      @latencies  = {}
      @app_server = []
    end

    def add(app_server, browser, latency)
      browser.each do |key, value|
        @browser[key] ||= []

        @browser[key] << value
      end

      latency.each do |key, value|
        @latencies[key] ||= []

        @latencies[key] << value
      end

      @app_server << app_server
    end

    def to_s
      [ heading_s,
        spacer_s,
        app_heading_s,
        app_server_s,
        spacer_s,
        latency_heading_s,
        latency_s,
        spacer_s,
        browser_heading_s,
        browser_rows_s ].join
    end

    private

    def heading_s
      "\nTesting #{@url}" \
      "\nAt #{@time}" \
      + "\n#{@loops} loops\n" \
      + ''.center(35) \
      + 'Fastest'.ljust(10) \
      + 'Median'.ljust(10) \
      + 'Slowest'.ljust(10) \
      + 'Std Dev'.ljust(10) \
      + "\n" \
      + '-' * 75 \
    end

    def spacer_s
      "\n\n"
    end

    def browser_rows_s
      @browser.map { |browser, results| RowFormatter.new(Titleizer.new(browser).to_s, results) }.join("\n")
    end

    def app_server_s
      RowFormatter.new('Total application time', @app_server)
    end

    def latency_s
      @latencies.map { |domain, values| RowFormatter.new(domain, values) }.join("\n")
    end

    def latency_heading_s
      "Host latency:\n".colorize(:yellow)
    end

    def browser_heading_s
      "Browser performance:\n".colorize(:yellow)
    end

    def app_heading_s
      "Server performance:\n".colorize(:yellow)
    end
  end
end
