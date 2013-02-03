module WebsiteBenchmarker
  class Results
    def initialize
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
      "\n" \
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
