module WBench
  class Results
    def initialize(url, loops)
      @url     = url
      @loops   = loops
      @time    = Time.now.asctime
      @results = {}
    end

    def add(timing_hash)
      timing_hash.each do |key, value|
        @results[key] ||= []

        @results[key] << value
      end
    end

    def to_s
      heading_s + rows_s
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
      + "\n\n"
    end

    def rows_s
      @results.map { |result| RowFormatter.new(result) }.join("\n")
    end
  end
end
