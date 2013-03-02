module WBench
  class ResultsFormatter
    def initialize(results)
      @results = results
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
      "\nTesting #{@results.url}" \
        "\nAt #{@results.time}" \
        + "\n#{@results.loops} loops\n" \
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
      @results.browser.map { |browser, results| RowFormatter.new(Titleizer.new(browser).to_s, results) }.join("\n")
    end

    def app_server_s
      RowFormatter.new('Total application time', @results.app_server)
    end

    def latency_s
      @results.latency.map { |domain, values| RowFormatter.new(domain, values) }.join("\n")
    end

    def latency_heading_s
      print_with_color("Host latency:\n", :yellow)
    end

    def browser_heading_s
      print_with_color("Browser performance:\n", :yellow)
    end

    def app_heading_s
      print_with_color("Server performance:\n", :yellow)
    end
    
    def print_with_color(str, color)
      # it no color is set, return without color
      $NO_COLOR ? str : str.colorize(color)
    end
  end
end
