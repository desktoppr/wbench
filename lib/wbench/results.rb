module WBench
  class Results
    def initialize(url, loops)
      @url              = url
      @loops            = loops
      @time             = Time.now.asctime
      @timings          = {}
      @app_responses = []
    end

    def add(timing_hash, app_response)
      timing_hash.each do |key, value|
        @timings[key] ||= []

        @timings[key] << value
      end

      @app_responses << app_response
    end

    def to_s
      [ heading_s,
        spacer_s,
        app_response_s,
        spacer_s,
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
      + "\n" \
      + '-' * 65 \
    end

    def spacer_s
      "\n\n"
    end

    def timing_rows_s
      @timings.map { |result| RowFormatter.new(*result) }.join("\n")
    end

    def app_response_s
      RowFormatter.new('App Server Response', @app_responses)
    end
  end
end
