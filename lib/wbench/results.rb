module WBench
  class Results
    def initialize(url, loops)
      @url           = url
      @loops         = loops
      @time          = Time.now.asctime
      @timings       = {}
      @latencies     = {}
      @app_responses = []
    end

    def add(timing_hash, app_response, asset_latencies)
      timing_hash.each do |key, value|
        @timings[key] ||= []

        @timings[key] << value
      end

      asset_latencies.each do |key, value|
        @latencies[key] ||= []

        @latencies[key] << value
      end

      @app_responses << app_response
    end

    def to_s
      [ heading_s,
        spacer_s,
        app_heading_s,
        app_response_s,
        spacer_s,
        latency_heading_s,
        asset_latencies_s,
        spacer_s,
        browser_heading_s,
        timing_rows_s ].join
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

    def timing_rows_s
      @timings.map { |timing, results| RowFormatter.new(Titleizer.new(timing).to_s, results) }.join("\n")
    end

    def app_response_s
      RowFormatter.new('Total application time', @app_responses)
    end

    def asset_latencies_s
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
